import 'package:dio/dio.dart';
import 'package:peanut/common/utils/custom_snackbar.dart';
import 'package:peanut/common/utils/custom_txt.dart';
import 'package:peanut/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:peanut/network/api_config.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      final statusCode = err.response?.statusCode;
      final context = Get.context;

      switch (statusCode) {
        case 401:
          if (err.requestOptions.path ==
              '${ApiConfig.baseUrl}/IsAccountCredentialsCorrect') {
            showCustomSnackbar(context!, CustomText.loginError);
          } else {
            showCustomSnackbar(context!, CustomText.unauthorizedAccess);
            logout();
          }
          break;
        case 500:
          showCustomSnackbar(context!, CustomText.internalServerError);
          if (err.response?.data == CustomText.accessDenied) {
            logout();
          }
          break;
        case 400:
          showCustomSnackbar(context!, CustomText.invalidRequest);
          break;
        default:
          showCustomSnackbar(context!, CustomText.genericError);
        // Handle other status codes as needed
      }
    }

    // Call the original error handlerr.
    handler.next(err);
  }

  void logout() {
    final authController = Get.find<AuthController>();
    authController.logout();
  }
}
