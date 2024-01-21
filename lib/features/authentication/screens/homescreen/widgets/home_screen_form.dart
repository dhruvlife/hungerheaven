import 'package:flutter/material.dart';
import 'package:vision/features/authentication/screens/signup/signup.dart';
import 'package:vision/features/authentication/screens/login/login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Login'),
              Tab(text: 'Signup'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            LoginScreen(),
            SignupScreen(),
          ],
        ),
      ),
    );
  }
}
