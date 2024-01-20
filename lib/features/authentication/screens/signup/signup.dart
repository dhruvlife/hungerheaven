import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vision/common/widgets/login_signup/form_divider.dart';
import 'package:vision/common/widgets/login_signup/social_icon.dart';
import 'package:vision/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:vision/utils/constants/colors.dart';
import 'package:vision/utils/constants/sizes.dart';
import 'package:vision/utils/constants/text_strings.dart';
import 'package:vision/utils/helpers/helper_functions.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //text
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              TSignUpForm(),

            ],
          ),
        ),
      ),
    );
  }
}



