import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peanut/common/dialog/custom_dialog.dart'; // Update this import if needed
import 'package:peanut/common/utils/app_colors.dart';
import 'package:peanut/common/widgets/custom_button.dart'; // Update this import if needed
import 'package:peanut/controllers/auth_controller.dart';

class DashboardView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool confirmExit = await showExitConfirmationDialog(context);
        return confirmExit ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Dashboard')),
          automaticallyImplyLeading: false, // Remove the default back button
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'Welcome to the',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blue,
                ),
              ),
              Text(
                'Peanut Service!',
                style: TextStyle(
                  fontSize: 32, // Increase the font size
                  fontWeight: FontWeight.bold,
                  color: AppColors.orange,
                  backgroundColor: AppColors.blue, // Use dark blue as the background color
                ),
              ),

              // SizedBox(height: 20), // Add spacing

              Expanded(
                child: Center(
                  child: GridView.count(
                    crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 4 : 2,
                    shrinkWrap: true,
                    children: [
                      CustomButton(
                        title: 'Profile',
                        iconData: Icons.person,
                        onPressed: () {
                          Get.toNamed('/profile');
                        },
                      ),
                      CustomButton(
                        title: 'Trades',
                        iconData: Icons.account_balance,
                        onPressed: () {
                          Get.toNamed('/accountinfo');
                        },
                      ),
                      CustomButton(
                        title: 'Campaigns',
                        iconData: Icons.campaign,
                        onPressed: () {
                          Get.toNamed('/promo');
                        },
                      ),
                      CustomButton(
                        title: 'Logout',
                        iconData: Icons.logout,
                        onPressed: () {
                          authController.logout();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
