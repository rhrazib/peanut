import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the profile page
                Get.toNamed('/profile');
              },
              child: Text('View Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the trade list page
                Get.toNamed('/trades');
              },
              child: Text('View Trades'),
            ),
            // Add more buttons for other modules if needed.
          ],
        ),
      ),
    );
  }
}
