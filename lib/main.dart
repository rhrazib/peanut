import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peanut/views/auth_view.dart';
import 'package:peanut/views/dashboard_view.dart';
import 'package:peanut/views/profile_view.dart';
import 'package:peanut/views/trade_list_view.dart';
import 'package:peanut/controllers/auth_controller.dart';
import 'package:peanut/controllers/profile_controller.dart'; // Import ProfileController

void main() {
  Get.put(AuthController());
  Get.put(ProfileController()); // Initialize ProfileController
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => AuthView()),
        GetPage(name: '/dashboard', page: () => DashboardPage()),
        GetPage(name: '/profile', page: () => ProfileView()),
        GetPage(name: '/accountinfo', page: () => TradesList()),//AccountInfoView()), // Make sure you have the correct view name
      ],
    );
  }
}
