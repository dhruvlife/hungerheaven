import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vision/common/widgets/login_signup/form_divider.dart';
import 'package:vision/common/widgets/login_signup/social_icon.dart';
import 'package:vision/features/authentication/screens/signup/verify_email.dart';
import 'package:vision/features/authentication/screens/signup/widgets/terms_condition_checkbox.dart';
import 'package:vision/utils/constants/sizes.dart';
import 'package:vision/utils/constants/text_strings.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TSignUpForm extends StatelessWidget {
  const TSignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailAddress = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController fullName = TextEditingController();
    TextEditingController phoneNo = TextEditingController();
    dynamic db = FirebaseFirestore.instance;
    /*Future<void> _signup() async {
      try {
        print("Email: ${emailAddress.text}\nPassword: ${password.text}");
        // Create a new user with a first and last name
        final user = <String, dynamic>{
          "fullname": fullName.text,
          "email": emailAddress.text,
          "phone": phoneNo.text,
          "password": password.text,
        };

// Add a new document with a generated ID
        db.collection("users").add(user).then((DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'));
        // final credential =
        //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
        //   email: emailAddress.text,
        //   password: password.text,
        // );
        // } on FirebaseAuthException catch (e) {
        //   if (e.code == 'weak-password') {
        //     print('The password provided is too weak.');
        //   } else if (e.code == 'email-already-in-use') {
        //     print('The account already exists for that email.');
        //   }
      } catch (e) {
        print(e);
      }
    }
    */
    Future<void> _signup() async {
      try {
        // Check if the email or phone number already exists
        QuerySnapshot emailQuery = await db
            .collection("users")
            .where("email", isEqualTo: emailAddress.text.trim())
            .get();

        QuerySnapshot phoneQuery = await db
            .collection("users")
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

        // final user = <String, dynamic>{
        //   "fullname": fullName.text,
        //   "email": emailAddress.text,
        //   "phone": phoneNo.text,
        //   "password": password.text,
        // };

        // // Add a new document with a generated ID
        // DocumentReference doc = await db.collection("users").add(user);
        // print('DocumentSnapshot added with ID: ${doc.id}');
      } catch (e) {
        debugPrint("Error: $e");
      }
    }

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
                      controller: fullName,
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
                controller: emailAddress,
                validator: controller._validateEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: TTexts.email,
                  prefixIcon: Icon(Iconsax.direct),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TextFormField(
                controller: phoneNo,
                validator: controller._validatePhone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: TTexts.phoneNo,
                  prefixIcon: Icon(Iconsax.call),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TextFormField(
                controller: password,
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
              const TTermsAndConditionCheckbox(),
              const SizedBox(height: TSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _signup(),
                  child: const Text(TTexts.createAccount),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              TFormDivider(
                dividerText: TTexts.orSignUpWith.capitalize!,
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
      return 'Password must be have 8 character and contains 1 Uppercase, LowerCase,Digit & Special Character.';
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
    update(); // Notify GetX that the state has chsanged
  }
}
