import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peanut/views/auth_view.dart';
import 'package:peanut/views/account_info.dart';
import 'package:peanut/views/dashboard_view.dart';
import 'package:peanut/views/profile_view.dart';
import 'package:peanut/views/trade_list_view.dart';
import 'package:peanut/controllers/auth_controller.dart';


void main() {
  Get.put(AuthController());
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
      ],
    );
  }
}
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Peanut',
//       initialRoute: '/login',
//       getPages: [
//         GetPage(name: '/login', page: () => AuthView()),
//         GetPage(name: '/dashboard', page: () => DashboardView()),
//         GetPage(name: '/profile', page: () => ProfileView()),
//         GetPage(name: '/trades', page: () => TradesList()),
//       ],
//     );
//   }
// }
