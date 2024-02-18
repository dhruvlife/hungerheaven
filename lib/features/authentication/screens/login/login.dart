import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:vision/common/styles/spacing_style.dart';
import 'package:vision/common/widgets/login_signup/form_divider.dart';
import 'package:vision/common/widgets/login_signup/social_icon.dart';
import 'package:vision/features/authentication/screens/login/widgets/login_form.dart';
import 'package:vision/features/authentication/screens/login/widgets/login_header.dart';
import 'package:vision/utils/constants/sizes.dart';
import 'package:vision/utils/constants/text_strings.dart';
import 'package:vision/utils/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              TLoginHeader(dark: dark),

              //form

              const TLoginForm(),

              TFormDivider(dividerText: TTexts.orSignInWith.capitalize!,),

              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              const TSocialicon(),

              
            ],
          ),
        ),
      ),
    );
  }
}





