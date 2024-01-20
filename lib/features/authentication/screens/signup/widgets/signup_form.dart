// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:get/get_utils/get_utils.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:vision/common/widgets/login_signup/form_divider.dart';
// import 'package:vision/common/widgets/login_signup/social_icon.dart';
// import 'package:vision/features/authentication/screens/signup/verify_email.dart';
// import 'package:vision/features/authentication/screens/signup/widgets/terms_condition_checkbox.dart';
// import 'package:vision/utils/constants/colors.dart';
// import 'package:vision/utils/constants/sizes.dart';
// import 'package:vision/utils/constants/text_strings.dart';
// import 'package:vision/utils/helpers/helper_functions.dart';

// class TSignUpForm extends StatelessWidget {
//   const TSignUpForm({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     ///validator

//     bool submitAttempted = false;
//     bool passwordVisible = false;
//     final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
//     String? _validateEmail(String? value) {
//       if (submitAttempted && (value == null || value.isEmpty)) {
//         return 'Please enter your email';
//       } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
//           .hasMatch(value!)) {
//         return 'Please enter a valid email address';
//       }
//       return null;
//     }

//     String? _validatePassword(String? value) {
//       if (submitAttempted && (value == null || value.isEmpty)) {
//         return 'Please enter your password';
//       } else if (!RegExp(
//               r'^(?=.{8,})(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+*!=]).*$')
//           .hasMatch(value!)) {
//         return 'Password must be have 8 character and contains\n1 Uppercase, LowerCase,Digit & Special Character.';
//       }
//       return null;
//     }

//     String? _validateName(String? value) {
//       if (submitAttempted && (value == null || value.isEmpty)) {
//         return 'Please enter your name';
//       } else if (!RegExp(r'^[a-zA-Z]+ [a-zA-Z]+$').hasMatch(value!)) {
//         return 'Please enter your name in the format "First Last"';
//       }
//       return null;
//     }

//     String? _validatePhone(String? value) {
//       if (submitAttempted && (value == null || value.isEmpty)) {
//         return 'Please enter your phone number';
//       } else if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value!)) {
//         return 'Please enter a valid 10-digit\nphone number starting with 6-9';
//       }
//       return null;
//     }

//     ///validator
//     ///
//     /*

//     */

//     return Form(
//       key: signupFormKey,
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: TextFormField(
//                   validator: _validateName,
//                   expands: false,
//                   decoration: const InputDecoration(
//                     labelText: TTexts.fullName,
//                     prefixIcon: Icon(Iconsax.user),
//                   ),
//                 ),
//               ),

//               /*const SizedBox(
//                 width: TSizes.spaceBtwItems,
//               ),
//               Expanded(
//                 child: TextFormField(
//                   expands: false,
//                   decoration: const InputDecoration(
//                     labelText: TTexts.lastName,
//                     prefixIcon: Icon(Iconsax.user),
//                   ),
//                 ),
//               ),*/
//             ],
//           ),
//           const SizedBox(
//             height: TSizes.spaceBtwItems,
//           ),

//           /*
//           TextFormField(

//             expands: false,
//             decoration: const InputDecoration(
//               labelText: TTexts.username,
//               prefixIcon: Icon(Iconsax.user_edit),
//             ),
//           ),
//           const SizedBox(
//             height: TSizes.spaceBtwItems,
//           ),
//           */

//           TextFormField(
//             expands: false,
//             validator: _validateEmail,
//             keyboardType: TextInputType.emailAddress,
//             decoration: const InputDecoration(
//               labelText: TTexts.email,
//               prefixIcon: Icon(Iconsax.direct),
//             ),
//           ),
//           const SizedBox(
//             height: TSizes.spaceBtwItems,
//           ),
//           TextFormField(
//             validator: _validatePhone,
//             expands: false,
//             keyboardType: TextInputType.phone,
//             decoration: const InputDecoration(
//               labelText: TTexts.phoneNo,
//               prefixIcon: Icon(Iconsax.call),
//             ),
//           ),
//           const SizedBox(
//             height: TSizes.spaceBtwItems,
//           ),
//           TextFormField(
//             validator: _validatePassword,
//             obscureText: !passwordVisible,
//             decoration: InputDecoration(
//               prefixIcon: Icon(Iconsax.password_check5),
//               labelText: TTexts.password,
//               // suffixIcon: GestureDetector(child: Icon(Iconsax.eye_slash5), onTap: () {

//               // },)

//             ),
//           ),
//           const SizedBox(
//             height: TSizes.spaceBtwItems,
//           ),

//           const TTermsAndConditionCheckbox(),

//           const SizedBox(
//             height: TSizes.spaceBtwSections,
//           ),

//           //Button
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () => Get.to(() => const VerifyEmailScreen()),
//               child: const Text(TTexts.createAccount),
//             ),
//           ),

//           const SizedBox(
//             height: TSizes.spaceBtwSections,
//           ),
//           TFormDivider(
//             dividerText: TTexts.orSignUpWith.capitalize!,
//           ),
//           const SizedBox(
//             height: TSizes.spaceBtwSections,
//           ),

//           const TSocialicon(),
//         ],
//       ),
//     );
//   }
// }

// Here gpt code
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vision/common/widgets/login_signup/form_divider.dart';
import 'package:vision/common/widgets/login_signup/social_icon.dart';
import 'package:vision/features/authentication/screens/signup/verify_email.dart';
import 'package:vision/features/authentication/screens/signup/widgets/terms_condition_checkbox.dart';
import 'package:vision/utils/constants/sizes.dart';
import 'package:vision/utils/constants/text_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
class TSignUpForm extends StatelessWidget {
  const TSignUpForm({Key? key}) : super(key: key);

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
    print("Email: ${emailAddress.text}\nPassword: ${password.text}");
    
    // Check if the email or phone number already exists
    QuerySnapshot emailQuery = await db
        .collection("users")
        .where("email", isEqualTo: emailAddress.text)
        .get();
    
    QuerySnapshot phoneQuery = await db
        .collection("users")
        .where("phone", isEqualTo: phoneNo.text)
        .get();

    if (emailQuery.docs.isNotEmpty || phoneQuery.docs.isNotEmpty) {
      // Email or phone number already exists, handle accordingly
      print("Error: Email or phone number already exists.");
      // You can throw an exception, show an error message, or handle it as needed.
      return;
    }

    // Create a new user with a first and last name
    final user = <String, dynamic>{
      "fullname": fullName.text,
      "email": emailAddress.text,
      "phone": phoneNo.text,
      "password": password.text,
    };

    // Add a new document with a generated ID
    DocumentReference doc = await db.collection("users").add(user);
    print('DocumentSnapshot added with ID: ${doc.id}');
    
  } catch (e) {
    print("Error: $e");
  }
};

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
                  prefixIcon: Icon(Iconsax.password_check5),
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
                  // onPressed: () => Get.to(() => const VerifyEmailScreen()),
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
        .hasMatch(value!)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if ((value == null || value.isEmpty)) {
      return 'Please enter your password';
    } else if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
        .hasMatch(value!)) {
      return 'Password must be have 8 character and contains\n1 Uppercase, LowerCase,Digit & Special Character.';
    }
    return null;
  }

  String? _validateName(String? value) {
    if ((value == null || value.isEmpty)) {
      return 'Please enter your name';
    } else if (!RegExp(r'^[a-zA-Z]+ [a-zA-Z]+$').hasMatch(value!)) {
      return 'Please enter your name in the format "First Last"';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if ((value == null || value.isEmpty)) {
      return 'Please enter your phone number';
    } else if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value!)) {
      return 'Please enter a valid 10-digit\nphone number starting with 6-9';
    }
    return null;
  }

  void togglePasswordVisibility() {
    passwordVisible = !passwordVisible;
    update(); // Notify GetX that the state has chsanged
  }
}
