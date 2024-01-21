import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vision/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:vision/features/authentication/controllers/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:vision/features/authentication/controllers/onboarding/widgets/onboarding_next_button.dart';
import 'package:vision/features/authentication/controllers/onboarding/widgets/onboarding_page.dart';
import 'package:vision/features/authentication/controllers/onboarding/widgets/onboarding_skip.dart';
import 'package:vision/features/authentication/screens/homescreen/widgets/home_screen_form.dart';
import 'package:vision/features/authentication/screens/login/login.dart';
import 'package:vision/utils/constants/image_strings.dart';
import 'package:vision/utils/constants/text_strings.dart';
import 'dart:async';

class onBoardingScreen extends StatefulWidget {
  const onBoardingScreen({super.key});

  @override
  onBoardingScreenState createState() => onBoardingScreenState();
}

class onBoardingScreenState extends State<onBoardingScreen> {
  static const String KEYLOGIN = "login";
  @override
  void initState() {
    super.initState();
    whereToGo();
  }

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

  void whereToGo() async {
    var sharedPref = GetStorage();
    bool isLogin = sharedPref.read("KEYLOGIN");

    Timer(const Duration(seconds: 3), () {
      if (isLogin != null) {
        if (isLogin == true) {
          Get.to(() => HomeScreen());
        } else {
          Get.to(() => LoginScreen());
        }
      } else {
        Get.to(() => LoginScreen());
      }
    });
  }
}
