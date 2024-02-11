import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vision/features/authentication/screens/homescreen/widgets/add_food.dart';
import 'package:vision/features/authentication/screens/homescreen/widgets/profile.dart';
import 'package:vision/features/authentication/screens/login/login.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final storage = GetStorage();
    Future<void> clearAllData() async {
      await storage.erase();
      Fluttertoast.showToast(msg: "Logout Sucess!");
      Future.delayed(const Duration(seconds: 1));
      Get.to(() => const LoginScreen());
    }

    return  Scaffold(
      appBar: AppBar(title: Text("Home Screen"),
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: [IconButton(onPressed: ()=> clearAllData(), icon: Icon(Icons.logout_rounded))],),
      body: Container(height: 100, width: 300, child: Center(child: Text("Home Screen")),),
    );
  }
}
