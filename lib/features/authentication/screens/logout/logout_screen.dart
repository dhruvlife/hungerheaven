import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../login/login.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: clearAllData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logos/logout.gif',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Logging you out...',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        } else {
          // After data is cleared, navigate to LoginScreen
          return const Scaffold();
        }
      },
    );
  }

  Future<void> clearAllData() async {
    final storage = GetStorage();
    await storage.erase();
    Fluttertoast.showToast(msg: "Logout Successful!");
    await Future.delayed(const Duration(seconds: 3)); // Wait for 2 seconds
    Get.offAll(() => const LoginScreen());
  }
}
