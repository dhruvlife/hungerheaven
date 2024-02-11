
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';
import 'package:vision/features/authentication/screens/homescreen/widgets/add_food.dart';
import 'package:vision/features/authentication/screens/homescreen/widgets/delivery.dart';
import 'package:vision/features/authentication/screens/homescreen/widgets/home_screen_form.dart';
import 'package:vision/features/authentication/screens/homescreen/widgets/profile.dart';
import 'package:vision/features/authentication/screens/login/login.dart';
import 'package:vision/features/authentication/screens/signup/signup.dart';

import 'package:vision/utils/constants/colors.dart';
import 'package:vision/utils/helpers/helper_functions.dart';


class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =Get.put(NavigationController());
    final darkmode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        ()=> NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value =index ,
          backgroundColor: darkmode?TColors.black:TColors.white,
          indicatorColor: darkmode?TColors.white.withOpacity(0.1):TColors.black.withOpacity(0.1),
          destinations:const [
          NavigationDestination(icon:Icon(Iconsax.home), label:'Home'),
          NavigationDestination(icon:Icon(Iconsax.shop), label:'food'),
          NavigationDestination(icon:Icon(Iconsax.routing), label:'delivery'),
          NavigationDestination(icon:Icon(Iconsax.user ), label:'Profile'),
          
        ]),
      ),
      body: Obx (()=> controller.Screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  // ignore: non_constant_identifier_names
  final Screens = [const HomeScreen(),const Addfood(),const delivery(),const Profile(),];
}


