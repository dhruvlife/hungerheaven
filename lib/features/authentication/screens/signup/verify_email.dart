import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vision/common/widgets/success%20screen/success_screen.dart';
import 'package:vision/features/authentication/screens/login/login.dart';
import 'package:vision/utils/constants/image_strings.dart';
import 'package:vision/utils/constants/sizes.dart';
import 'package:vision/utils/constants/text_strings.dart';
import 'package:vision/utils/helpers/helper_functions.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.offAll(() => const LoginScreen()),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //image
              Image(
                image: AssetImage(TImages.deliveredEmailIllustration),
                width: THelperFunctions.screenWidth(),
              ),

              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Title & subtitle
              Text(
                TTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),

              SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              Text(
                'support@Vision.com',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),

              SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              Text(
                TTexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),

              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(
                    () =>  SuccessScreen(
                      image: TImages.staticSuccessIllustration,
                      title: TTexts.yourAccountCreatedTitle,
                      subtitle: TTexts.yourAccountCreatedSubTitle,
                      onPressed: () => Get.to(() => const LoginScreen()),
                    ),
                  ),
                  child: const Text(TTexts.tContinue),
                ),
              ),

              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Get.to(() => const VerifyEmailScreen()),
                  child: const Text(TTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
