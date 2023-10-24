import 'package:get/get.dart';
import 'package:peanut/controllers/auth_controller.dart';

class RouteManagement {
  final AuthController _authController = Get.find<AuthController>();

  void logout() {
    _authController.logout();
  }
}
