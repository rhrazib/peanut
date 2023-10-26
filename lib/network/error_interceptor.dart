import 'package:dio/dio.dart';
import 'package:peanut/common/utils/app_snackbar.dart';
import 'package:peanut/common/utils/app_txt.dart';
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
          if (err.requestOptions.path != AppText.authApi) {
            showAppSnackbar(context!, AppText.unauthorizedAccess);
            logout();
          }
          break;
        case 500:
          if (err.requestOptions.path != AppText.authApi) {
            showAppSnackbar(context!, AppText.internalServerError);
          }
          if (err.response?.data == AppText.accessDenied) {
            logout();
          }
          break;
        case 400:
          showAppSnackbar(context!, AppText.invalidRequest);
          break;
        default:
          showAppSnackbar(context!, AppText.genericError);
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
