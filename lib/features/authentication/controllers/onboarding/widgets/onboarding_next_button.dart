import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vision/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:vision/utils/constants/colors.dart';
import 'package:vision/utils/constants/sizes.dart';
import 'package:vision/utils/device/device_utility.dart';
import 'package:vision/utils/helpers/helper_functions.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => onBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            backgroundColor: dark ? TColors.primary : Colors.black),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}
