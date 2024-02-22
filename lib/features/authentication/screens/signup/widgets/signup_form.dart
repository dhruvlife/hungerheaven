import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vision/common/widgets/login_signup/form_divider.dart';
import 'package:vision/common/widgets/login_signup/social_icon.dart';
import 'package:vision/features/authentication/screens/signup/verify_email.dart';
import 'package:vision/utils/constants/sizes.dart';
import 'package:vision/utils/constants/text_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

class TSignUpForm extends StatelessWidget {
  const TSignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TSignUpController>(
      init: TSignUpController(),
      builder: (controller) {
        return Form(
          key: controller.signupFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.fullName,
                      validator: controller._validateName,
                      textCapitalization: TextCapitalization.words,
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: TTexts.fullName,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TextFormField(
                controller: controller.emailAddress,
                validator: controller._validateEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: TTexts.email,
                  prefixIcon: Icon(Iconsax.direct),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TextFormField(
                controller: controller.phoneNo,
                validator: controller._validatePhone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: TTexts.phoneNo,
                  prefixIcon: Icon(Iconsax.call),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TextFormField(
                controller: controller.password,
                validator: controller._validatePassword,
                obscureText: !controller.passwordVisible,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check5),
                  labelText: TTexts.password,
                  suffixIcon: IconButton(
                    icon: Icon(controller.passwordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              // const TTermsAndConditionCheckbox(),
              const SizedBox(height: TSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                   style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.green,
                      side: const BorderSide(color: Colors.amber)
                      ),
                  onPressed: () async {
                    if (controller.isProcessing) return;

                    bool isValid = controller.validateForm();
                    if (isValid) {
                      await controller.signup();
                    }
                  },
                  child: controller.isProcessing
                      ? const CircularProgressIndicator()
                      : const Text(TTexts.createAccount),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              const TFormDivider(
                dividerText: TTexts.orSignUpWith,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              const TSocialicon(),
            ],
          ),
        );
      },
    );
  }
}

class TSignUpController extends GetxController {
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool isProcessing = false;
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  dynamic db = FirebaseFirestore.instance;

  String? _validateEmail(String? value) {
    if ((value == null || value.isEmpty)) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
        .hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if ((value == null || value.isEmpty)) {
      return 'Please enter your password';
    } else if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
        .hasMatch(value)) {
      return 'Password must be have 8 character and contains 1 Uppercase, LowerCase, Digit & Special Character.';
    }
    return null;
  }

  String? _validateName(String? value) {
    if ((value == null || value.isEmpty)) {
      return 'Please enter your name';
    } else if (!RegExp(r'^[a-zA-Z]+ [a-zA-Z]+$').hasMatch(value)) {
      return 'Please enter your name in the format "First Last"';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if ((value == null || value.isEmpty)) {
      return 'Please enter your phone number';
    } else if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number\nstarting with 6-9';
    }
    return null;
  }

  void togglePasswordVisibility() {
    passwordVisible = !passwordVisible;
    update(); // Notify GetX that the state has changed
  }

  bool validateForm() {
    if (signupFormKey.currentState?.validate() ?? false) {
      return true;
    }
    return false;
  }

  Future<void> signup() async {
    try {
      // Check if the email or phone number already exists
      QuerySnapshot emailQuery = await db
          .collection("rest_owners")
          .where("email", isEqualTo: emailAddress.text.trim())
          .get();

      QuerySnapshot phoneQuery = await db
          .collection("rest_owners")
          .where("phone", isEqualTo: phoneNo.text.trim())
          .get();

      if (emailQuery.docs.isNotEmpty || phoneQuery.docs.isNotEmpty) {
        Fluttertoast.showToast(
            msg: "Email Or Phone Number Already Registered");
        return;
      } else {
        final sharedPref = GetStorage();
        sharedPref.write("signup_name", fullName.text.trim());
        sharedPref.write("signup_email", emailAddress.text.trim());
        sharedPref.write("signup_phone", phoneNo.text.trim());
        sharedPref.write("signup_password", password.text.trim());
        Get.to(() => const VerifyEmailScreen());
      }

      isProcessing = false;
      update(); // Notify GetX that the state has changed
    } catch (e) {
      debugPrint("Error: $e");
      isProcessing = false;
      update(); // Notify GetX that the state has changed
    }
  }
}
