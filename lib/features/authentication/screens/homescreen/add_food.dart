import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vision/features/authentication/screens/signup/signup.dart';
import 'package:vision/utils/constants/sizes.dart';
import 'package:vision/utils/constants/text_strings.dart';

class AddFood extends StatelessWidget {
  const AddFood({super.key});

  @override
  Widget build(BuildContext context) {
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
                  //controller: emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.restaurant_menu_rounded),
                    labelText: TTexts.foodname,
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields ,
                ),
                TextFormField(
                  
                  //validator: _validateEmail,
                  //controller: emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.fastfood_rounded),
                    labelText: TTexts.foodcata,
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields ,
                ),
                TextFormField(
                  //validator: _validateEmail,
                  //controller: emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.food_bank_rounded),
                    labelText: TTexts.foodq,
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields ,
                ),
                TextFormField(
                  //validator: _validatePassword,
                  //controller: passwordController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.emoji_food_beverage_rounded),
                    labelText: TTexts.foodtype,
                    //suffixIcon: Icon(Iconsax.eye_slash5)
                  ),
                ),
                
                const SizedBox(
                  height: TSizes.spaceBtwSections*2 ,
                ),
                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(TTexts.addfood),
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
