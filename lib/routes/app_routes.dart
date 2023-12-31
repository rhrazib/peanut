import 'package:get/get.dart';
import 'package:peanut/views/auth_view.dart';
import 'package:peanut/views/dashboard_view.dart';
import 'package:peanut/views/profile_view.dart';
import 'package:peanut/views/promo_view.dart';
import 'package:peanut/views/trade_list_view.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => AuthView()),
    GetPage(name: '/dashboard', page: () => DashboardView()),
    GetPage(name: '/profile', page: () => ProfileView()),
    GetPage(name: '/accountinfo', page: () => TradeListView()), // Corrected import
    GetPage(name: '/promo', page: () => PromoView()), // Add this route for PromoView
  ];
}
