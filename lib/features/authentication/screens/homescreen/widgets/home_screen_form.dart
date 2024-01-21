import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vision/features/authentication/screens/homescreen/add_food.dart';
import 'package:vision/features/authentication/screens/homescreen/widgets/profile.dart';
import 'package:vision/features/authentication/screens/signup/signup.dart';
import 'package:vision/features/authentication/screens/login/login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    Future<void> clearAllData() async {
      await storage.erase();
      Fluttertoast.showToast(msg: "Logout Sucess!");
      Future.delayed(Duration(seconds: 1));
      Get.to(() => HomeScreen());
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  clearAllData();
                },
                icon: Icon(Icons.logout_rounded))
          ],
          centerTitle: true,
          title: const Text('Home Screen'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Add Food'),
              Tab(text: 'Profile'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AddFood(),
            Profile(),
          ],
        ),
      ),
    );
  }
}
