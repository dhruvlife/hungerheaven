import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vision/features/authentication/screens/login/login.dart';

class onBoardingController extends GetxController {
  static onBoardingController get instance => Get.find();

  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  void updatePageIndicator(Index) => currentPageIndex.value = Index;

  void dotNavigationClick(Index) {
    currentPageIndex.value = Index;
    pageController.jumpTo(Index);
  }

  void nextPage() {
    if (currentPageIndex.value == 2) {
      Get.offAll(const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage() {
    // currentPageIndex.value = 2;
    pageController.jumpTo(2);
    Get.offAll(LoginScreen());
  }
}
