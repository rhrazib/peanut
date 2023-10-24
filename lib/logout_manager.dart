import 'package:get/get.dart';
import 'package:peanut/controllers/auth_controller.dart';

class RouteManagement {
  final AuthController _authController = Get.find<AuthController>();

  // Private constructor
  RouteManagement._private();

  // Singleton instance
  static final RouteManagement _instance = RouteManagement._private();

  // Getter for the singleton instance
  factory RouteManagement() {
    return _instance;
  }

  void logout() {
    _authController.logout();
    Get.offAllNamed('/login');
  }
}
