import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peanut/UserTradesController.dart';
import 'package:peanut/auth_controller.dart';
import 'auth_view.dart';

void main() {
  // Initialize GetX
  WidgetsFlutterBinding.ensureInitialized();

  // Register AuthController
  Get.put(AuthController());

  // Register UserTradesController
 // Get.put(UserTradesController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthView(),
    );
  }
}
