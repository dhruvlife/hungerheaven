import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:vision/features/authentication/controllers/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:vision/features/authentication/controllers/onboarding/widgets/onboarding_next_button.dart';
import 'package:vision/features/authentication/controllers/onboarding/widgets/onboarding_page.dart';
import 'package:vision/features/authentication/controllers/onboarding/widgets/onboarding_skip.dart';
import 'package:vision/utils/constants/image_strings.dart';
import 'package:vision/utils/constants/text_strings.dart';

class onBoardingScreen extends StatelessWidget {
  const onBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(onBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: TImages.onBoardingImage1,
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage2,
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage3,
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),
          const OnBoardingSkip(),
          const OnBoardingDotNavigation(),
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}
