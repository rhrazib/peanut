import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peanut/controllers/auth_controller.dart';

class ProfileView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User Information'),
            SizedBox(height: 16),
            Obx(() {
              if (authController.accessToken.isNotEmpty) {
                return FutureBuilder<Map<String, dynamic>>(
                  future: authController.getAccountInformation(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final accountInfo = snapshot.data;
                      final name = accountInfo?['name'] ?? 'N/A';
                      final address = accountInfo?['address'] ?? 'N/A';
                      final balance = accountInfo?['balance'] ?? 'N/A';
                      final city = accountInfo?['city'] ?? 'N/A';
                      final country = accountInfo?['country'] ?? 'N/A';

                      return Column(
                        children: [
                          Text('User Name: $name'),
                          Text('User Address: $address'),
                          Text('User Balance: $balance'),
                          Text('User City: $city'),
                          Text('User Country: $country'),
                          // Add more properties as needed.
                        ],
                      );
                    }
                  },
                );
              } else {
                return Text('Please log in to view user information.');
              }
            }),
            SizedBox(height: 16),
            FutureBuilder<String>(
              future: authController.getLastFourNumbersPhone(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final lastFourNumbers = snapshot.data ?? 'N/A';
                  return Text('Last Four Numbers of Phone: $lastFourNumbers');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
