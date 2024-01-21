import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vision/features/authentication/screens/homescreen/widgets/home_screen_form.dart';
import 'package:vision/features/authentication/screens/signup/signup.dart';
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

    void _signIn() async {
      try {
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
          sharedPref.write("name", user["fullname"]);
          sharedPref.write("email", user["email"]);
          sharedPref.write("phone", user["phone_no"]);
          Fluttertoast.showToast(msg: "Login Success");
          Future.delayed(const Duration(seconds: 2));
          Get.to(() => HomeScreen());
          // Navigate to the desired screen or perform any other action with user details
        } else {
          debugPrint("User not found in Firestore");
          Fluttertoast.showToast(msg: "Invalid Email or Password!");
        }
      } catch (e) {
        Fluttertoast.showToast(msg: "Invalid Email or Password!");
        debugPrint("Sign In Error: $e");
        // Handle sign-in errors here
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

    return Form(
      key: loginFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections / 2),
        child: Column(
          children: [
            const SizedBox(
              height: TSizes.spaceBtwInputFields / 2,
            ),
            TextFormField(
              validator: _validateEmail,
              controller: emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right5),
                labelText: TTexts.email,
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields / 2,
            ),
            TextFormField(
              validator: _validatePassword,
              controller: passwordController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check5),
                  labelText: TTexts.password,
                  suffixIcon: Icon(Iconsax.eye_slash5)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: false, onChanged: (value) {}),
                    const Text(TTexts.rememberMe),
                  ],
                ),
                TextButton(
                    onPressed: () {}, child: const Text(TTexts.forgetPassword)),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections / 2,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _signIn();
                },
                child: const Text(TTexts.signIn),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignupScreen()),
                child: const Text(TTexts.createAccount),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections / 2,
            ),
          ],
        ),
      ),
    );
  }
}
