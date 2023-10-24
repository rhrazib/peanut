import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peanut/controllers/auth_controller.dart';


class DashboardView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        // Here, show a confirmation dialog when back button is pressed
        bool confirmExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Confirm Exit'),
            content: Text('Do you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Allow going back
                },
                child: Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Prevent going back
                },
                child: Text('No'),
              ),
            ],
          ),
        );

        return confirmExit ?? false; // Default behavior is to prevent going back.
      },
      child:  Scaffold(
        appBar: AppBar(title: Text('Dashboard')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome to the Dashboard!'),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed('/profile'); // Navigate to the profile page
                },
                child: Text('View Profile'),
              ),

              ElevatedButton(
                onPressed: () {
                  Get.toNamed('/accountinfo'); // Navigate to the account information page
                },
                child: Text('Account Information'),
              ),

              ElevatedButton(
                onPressed: () => authController.logout(),
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
