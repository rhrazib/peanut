import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peanut/views/auth_view.dart';
import 'package:peanut/views/account_info.dart';
import 'package:peanut/views/dashboard_view.dart';
import 'package:peanut/views/profile_view.dart';
import 'package:peanut/views/trade_list_view.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Peanut',
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => AuthView()),
        GetPage(name: '/dashboard', page: () => DashboardView()),
        GetPage(name: '/profile', page: () => ProfileView()),
        GetPage(name: '/trades', page: () => TradesList()),
      ],
    );
  }
}
