import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peanut/controllers/auth_controller.dart';


class DashboardPage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the Dashboard!'),
            ElevatedButton(
              onPressed: () => authController.logout(),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}