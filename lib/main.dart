import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peanut/controllers/promo_controller.dart';
import 'package:peanut/network/dio.dart';
import 'package:peanut/routes/app_routes.dart';
import 'package:peanut/controllers/auth_controller.dart';
import 'package:peanut/controllers/profile_controller.dart';
import 'package:peanut/controllers/trades_controller.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  DioClient.setupDio(); //setup dio client
  Get.put(AuthController());
  Get.put(ProfileController());
  Get.put(TradesController());
  Get.put(PromoController());

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
      getPages: AppRoutes.routes, // Use the routes from the routing file
    );
  }
}
