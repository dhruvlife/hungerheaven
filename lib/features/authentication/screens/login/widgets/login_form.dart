import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vision/features/authentication/screens/rest_rt.dart/login_rest.dart';

import 'package:vision/features/authentication/screens/signup/signup.dart';
import 'package:vision/navigation_menu.dart';
import 'package:vision/splash_screen.dart';
import 'package:vision/utils/constants/sizes.dart';
import 'package:vision/utils/constants/text_strings.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    RxBool isLoading = false.obs;

    void _signIn() async {
      try {
        isLoading = true.obs;
        final sharedPref = GetStorage();
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.toString().trim(),
          password: passwordController.text.toString().trim(),
        );

        final userQuery = await FirebaseFirestore.instance
            .collection("users")
            .where("email", isEqualTo: credential.user?.email)
            .get();

        if (userQuery.docs.isNotEmpty) {
          final user = userQuery.docs.first.data();
          final userId = userQuery.docs.first.id; // Fetching the document ID
          sharedPref.write('isLogin', true);
          sharedPref.write(SplashScreenState.KEYLOGIN, true);
          sharedPref.write("userId", userId);
          sharedPref.write("name", user["fullname"]);
          sharedPref.write("email", user["email"]);
          sharedPref.write("phone", user["phone"]);
          sharedPref.write("userId", userId); // Saving the document ID
          Fluttertoast.showToast(msg: "Login Success");
          Future.delayed(const Duration(seconds: 2));
          sharedPref.save();
          Get.to(() => const RestLogin());
          // Navigate to the desired screen or perform any other action with user details
        } else {
          debugPrint("User not found in Firestore");
          Fluttertoast.showToast(msg: "Invalid Email or Password!");
        }
      } catch (e) {
        Fluttertoast.showToast(msg: "Invalid Email or Password!");
        debugPrint("Sign In Error: $e");
        // Handle sign-in errors here
      } finally {
        isLoading = false.obs;
      }
    }

    final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
    String? _validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your email';
      } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
          .hasMatch(value)) {
        return 'Please enter a valid email address';
      }
      return null;
    }

    String? _validatePassword(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your password';
      } else if (!RegExp(
              r'^(?=.{8,})(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+*!=]).*$')
          .hasMatch(value)) {
        return 'Password must be have 8 character and contains\n1 Uppercase, LowerCase,Digit & Special Character.';
      }
      return null;
    }

    ///validator

    return GetBuilder<TSignInController>(
      init: TSignInController(),
      builder: (controller) {
        return Form(
          key: controller.signupFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: TSizes.spaceBtwItems),
              TextFormField(
                controller: emailController,
                validator: controller._validateEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: TTexts.email,
                  prefixIcon: Icon(Iconsax.direct),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TextFormField(
                controller: passwordController,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Do you have not any acount ?',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()));
                    },
                    child: Text('Sign Up here..'),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  // child: ElevatedButton(
                  //   onPressed: () => _signIn(),
                  //   child: const Text(TTexts.signIn),
                  // ),
                  child: ElevatedButton(
                    onPressed: (isLoading.isTrue)
                        ? null
                        : () async {
                            _signIn();
                          },
                    child: const Text('Submit'),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              if (isLoading.isTrue) const CircularProgressIndicator()
            ],
          ),
        );
      },
    );
  }
}

class TSignInController extends GetxController {
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

  void togglePasswordVisibility() {
    passwordVisible = !passwordVisible;
    update(); // Notify GetX that the state has chsanged
  }
}
