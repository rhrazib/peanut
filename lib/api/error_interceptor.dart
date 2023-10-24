import 'package:dio/dio.dart';
import 'package:peanut/controllers/auth_controller.dart';
import 'package:get/get.dart';
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response != null && err.response?.data == "Access denied") {
      // Access denied, log the user out.
      final authController = Get.find<AuthController>();
      authController.logout();

      // Optionally, you can navigate to the login page or show an error message.
      Get.offAllNamed('/login');
    }

    // Call the original error handler to continue processing the error.
    handler.next(err);
  }
}
