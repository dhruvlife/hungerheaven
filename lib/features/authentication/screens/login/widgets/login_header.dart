import 'package:flutter/material.dart';
import 'package:vision/utils/constants/image_strings.dart';
import 'package:vision/utils/constants/sizes.dart';
import 'package:vision/utils/constants/text_strings.dart';


class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //image --
    
        Image(
          height: 150,
          image: AssetImage(
              dark ? TImages.dark1AppLogo : TImages.dark1AppLogo),
        ),
        Text(
          TTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: TSizes.sm),
        Text(
          TTexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}