import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peanut/common/utils/app_colors.dart';
import 'package:peanut/controllers/auth_controller.dart';
import 'package:peanut/controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User Information',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  if (authController.accessToken.isNotEmpty)
                    FutureBuilder<Map<String, dynamic>>(
                      future: profileController.getAccountInformation(authController.accessToken.value, authController.accessInput.value),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                    )
                  else
                    Text(
                      'Please log in to view user information.',
                      style: TextStyle(fontSize: 18),
                    ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: FutureBuilder<String>(
                future: profileController.getLastFourNumbersPhone(authController.accessToken.value, authController.accessInput.value),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final lastFourNumbers = snapshot.data ?? 'N/A';

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Last Four Numbers of Phone',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          lastFourNumbers,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
