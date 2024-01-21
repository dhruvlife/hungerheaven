import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vision/features/authentication/screens/signup/signup.dart';
import 'package:vision/utils/constants/sizes.dart';
import 'package:vision/utils/constants/text_strings.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {

    var sharedPref = GetStorage();

    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController phone = TextEditingController();

    name.text = sharedPref.read("name") ?? 'Hunger Heaven';
    email.text = sharedPref.read("email") ?? 'hunger.heaven@gmail.com';
    phone.text = sharedPref.read("phone") ?? '1234567890';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        //key: loginFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections / 2),
          child: SingleChildScrollView(
            child: Column(
              
              children: [
                const SizedBox(
                  height: TSizes.spaceBtwInputFields ,
                ),
                TextFormField(
                  //validator: _validateEmail,
                  controller: name,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: "Full Name",
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields ,
                ),
                TextFormField(
                  
                  //validator: _validateEmail,
                  controller: email,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_rounded),
                    labelText: "Email",
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields ,
                ),
                TextFormField(
                  //validator: _validateEmail,
                  // initialValue: ,
                  controller: phone,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone_android_rounded),
                    labelText: 'Phone Number',
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections*2 ,
                ),
                
                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Update Profile'),
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections / 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}