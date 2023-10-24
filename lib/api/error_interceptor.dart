import 'package:dio/dio.dart';
import 'package:peanut/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:peanut/api/api_config.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      final statusCode = err.response?.statusCode;
      switch (statusCode) {
        case 401:
          if (err.requestOptions.path == '${ApiConfig.baseUrl}/IsAccountCredentialsCorrect') {
            // Customize error message for login API
            Get.snackbar('Login Failed', 'Incorrect login or password.',
                backgroundColor: Colors.red, colorText: Colors.white);
          } else {
            // Customize error message for profile API
            Get.snackbar('Failed', 'Unauthorized access.',
                backgroundColor: Colors.red, colorText: Colors.white);
            // Access denied, log the user out.
            final authController = Get.find<AuthController>();
            authController.logout();
            // Optionally, you can navigate to the login page or show an error message.
            Get.offAllNamed('/login');
          }
          break;
        case 500:
        // Internal Server Error (status code 500) - handle the error or show a message
          Get.snackbar('Server Error', 'Internal server error occurred.',
              backgroundColor: Colors.red, colorText: Colors.white);
          if (err.response?.data == "Access denied") {
            // Access denied, log the user out.
            final authController = Get.find<AuthController>();
            authController.logout();
            // navigate to the login
            Get.offAllNamed('/login');
          }

          break;
        case 400:
        // Bad Request (status code 400) - handle the error or show a message
          Get.snackbar('Bad Request', 'Invalid request.',
              backgroundColor: Colors.red, colorText: Colors.white);
          break;
        default:
        // Handle other status codes as needed
        // You can add more conditions to handle other status codes.
      }
    }

    // Call the original error handler to continue processing the error.
    handler.next(err);
  }
}
