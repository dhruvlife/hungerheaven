// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:vision/features/authentication/screens/homescreen/widgets/add_food.dart';
// import 'package:vision/features/authentication/screens/homescreen/widgets/profile.dart';
// import 'package:vision/features/authentication/screens/login/login.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final storage = GetStorage();
//     Future<void> clearAllData() async {
//       await storage.erase();
//       Fluttertoast.showToast(msg: "Logout Sucess!");
//       Future.delayed(const Duration(seconds: 1));
//       Get.to(() => const LoginScreen());
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home Screen"),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//               onPressed: () => clearAllData(), icon: Icon(Icons.logout_rounded))
//         ],
//       ),
//       body: Container(
      
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vision/features/authentication/screens/homescreen/widgets/add_food.dart';
import 'package:vision/features/authentication/screens/homescreen/widgets/profile.dart';
import 'package:vision/features/authentication/screens/login/login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();

    Future<void> clearAllData() async {
      await storage.erase();
      Fluttertoast.showToast(msg: "Logout Sucess!");
      await Future.delayed(const Duration(seconds: 1));
      Get.offAll(() => const LoginScreen());
    }

    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Home Screen"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => clearAllData(),
              icon: Icon(Icons.logout_rounded),
            )
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Ongoing'),
              Tab(text: 'Pending'),
              Tab(text: 'Success/Delivered'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OngoingTab(),
            PendingTab(),
            SuccessDeliveredTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => const Addfood());
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class OngoingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Ongoing Orders'),
    );
  }
}

class PendingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Pending Orders'),
    );
  }
}

class SuccessDeliveredTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Success/Delivered Orders'),
    );
  }
}
