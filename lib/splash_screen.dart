// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
// import 'package:trasheepartner/screens/shopkeeper/shop_approval_wait.dart';
// import 'package:trasheepartner/screens/shopkeeper/shop_details_add.dart';
// import 'package:trasheepartner/screens/shopkeeper/shop_homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vision/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:vision/features/authentication/screens/homescreen/widgets/home_screen_form.dart';
import 'package:vision/features/authentication/screens/login/login.dart';
import 'package:vision/features/authentication/screens/onboarding/onboarding.dart';
import 'package:vision/navigation_menu.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  static const String isShopApproved = "approve";
  static const String isShopAdded = "added";
  // ignore: constant_identifier_names
  static const String KEYLOGIN = "login";

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _animation,
              child: Image.asset(
                'assets/logos/t2.png',
                height: 380, // Increased height by 20%
                width: 380,
              ),
            ),
            FadeTransition(
                opacity: _animation,
                child: const Text(
                  "PARTNER",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                )),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void whereToGo() async {
    var sharedPref = GetStorage();
    await sharedPref.initStorage;
    var isLogin = sharedPref.read(KEYLOGIN);

    debugPrint("""Let's print the bool values\n
    1) Is login: $isLogin\n""");

    Timer(
      const Duration(seconds: 3),
      () {
        if (isLogin != null) {
          if (isLogin) {
            Get.to(NavigationMenu());
          } else {
            Get.to(LoginScreen()); // Replace with your actual file path;
          }
        } else {
          Get.to(onBoardingScreen());
        }
      },
    );
  }
}
