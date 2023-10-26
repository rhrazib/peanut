import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peanut/common/utils/app_colors.dart';
import 'package:peanut/controllers/auth_controller.dart';
import 'package:peanut/controllers/profile_controller.dart';
import 'package:peanut/common/utils/app_txt.dart';

class ProfileView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppText.userProfile),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppText.userInformation,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blue,
                      ),
                    ),
                    SizedBox(height: 16),
                    if (authController.accessToken.isNotEmpty)
                      FutureBuilder<Map<String, dynamic>>(
                        future: profileController.getAccountInformation(
                            authController.accessToken.value,
                            authController.accessInput.value),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red));
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
                                ListTile(
                                  leading: Icon(Icons.person),
                                  title: Text('Name: $name', style: TextStyle(color: Colors.black87)),
                                ),
                                ListTile(
                                  leading: Icon(Icons.location_on),
                                  title: Text('Address: $address', style: TextStyle(color: Colors.black87)),
                                ),
                                ListTile(
                                  leading: Icon(Icons.attach_money),
                                  title: Text('Balance: $balance', style: TextStyle(color: Colors.black87)),
                                ),
                                ListTile(
                                  leading: Icon(Icons.location_city),
                                  title: Text('City: $city', style: TextStyle(color: Colors.black87)),
                                ),
                                ListTile(
                                  leading: Icon(Icons.public),
                                  title: Text('Country: $country', style: TextStyle(color: Colors.black87)),
                                ),
                                // Add more properties as needed.
                              ],
                            );
                          }
                        },
                      )
                    else
                      Text(
                        AppText.pleaseLoginToViewInfo,
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder<String>(
                  future: profileController.getLastFourNumbersPhone(
                      authController.accessToken.value,
                      authController.accessInput.value),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red));
                    } else {
                      final lastFourNumbers = snapshot.data ?? 'N/A';

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                          AppText.lastFourNumbersOfPhone,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blue,
                            ),
                          ),
                          SizedBox(height: 8),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text(lastFourNumbers, style: TextStyle(fontSize: 18, color: Colors.black87)),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
