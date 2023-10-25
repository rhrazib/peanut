import 'package:dio/dio.dart';
import 'package:peanut/common/utils/custom_snackbar.dart';
import 'package:peanut/common/utils/custom_txt.dart';
import 'package:peanut/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:peanut/api/api_config.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      final statusCode = err.response?.statusCode;
      final context = Get.context;

      switch (statusCode) {
        case 401:
          if (err.requestOptions.path == '${ApiConfig.baseUrl}/IsAccountCredentialsCorrect') {
            showCustomSnackbar(context!, CustomText.loginError);
          } else {
            showCustomSnackbar(context!, CustomText.unauthorizedAccess);
            final authController = Get.find<AuthController>();
            authController.logout();
            Get.offAllNamed('/login');
          }
          break;
        case 500:
          showCustomSnackbar(context!, CustomText.internalServerError);
          if (err.response?.data == CustomText.accessDenied) {
            final authController = Get.find<AuthController>();
            authController.logout();
            Get.offAllNamed('/login');
          }
          break;
        case 400:
          showCustomSnackbar(context!, CustomText.invalidRequest);
          break;
        default:
          showCustomSnackbar(context!, CustomText.genericError);
      // Handle other status codes as needed
      // You can add more conditions to handle other status codes.
      }
    }

    // Call the original error handler to continue processing the error.
    handler.next(err);
  }
}


