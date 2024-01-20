import 'package:flutter/material.dart';
import 'package:vision/utils/constants/sizes.dart';
import 'package:vision/utils/constants/text_strings.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //headings
            

            Text(
              TTexts.forgetPasswordTitle,
              
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            //TextFeild

            //submit button
          ],
        ),
      ),
    );
  }
}
