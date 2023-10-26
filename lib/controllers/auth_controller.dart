import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:peanut/common/utils/app_snackbar.dart';
import 'package:peanut/common/utils/app_txt.dart';
import 'package:peanut/views/dashboard_view.dart';
import 'package:peanut/services/auth_service.dart';

class AuthController extends GetxController {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final Connectivity _connectivity = Connectivity();
  final AuthService authService = AuthService();

  final RxString accessToken = ''.obs;
  final RxString accessInput = ''.obs;

  final String accessTokenKey = 'access_token';
  final String tokenExpirationKey = 'token_expiration';
  final String loginKey = 'loginKey';

  final RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    final storedToken = await _storage.read(key: accessTokenKey);
    final loginInput = await _storage.read(key: loginKey);

    if (storedToken != null && loginInput != null) {
      accessToken.value = storedToken;
      accessInput.value = loginInput;
      Get.off(DashboardView()); // Redirect to the dashboard
    }
  }

  Future<bool> checkInternetConnection() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  Future<void> login(
      BuildContext context, String login, String password) async {
    isLoading.value = true;
    try {
      final isConnected = await checkInternetConnection();
      if (!isConnected) {
        showAppSnackbar(context, AppText.noInternetMessage);
        isLoading.value = false;
        return;
      }

      final response = await authService.login(login, password);

      if (response.containsKey('error')) {
        showAppSnackbar(context, AppText.loginError);
      } else {
        await _storage.write(key: accessTokenKey, value: response['token']);
        await _storage.write(key: loginKey, value: login);

        final currentTime = DateTime.now();
        final tokenExpiration = currentTime.add(
            Duration(minutes: 30)); // Replace with actual token expiration time
        await _storage.write(
            key: tokenExpirationKey, value: tokenExpiration.toIso8601String());

        accessToken.value = response['token'];
        accessInput.value = login;
        Get.toNamed('/dashboard');
      }
    } catch (e) {
      showAppSnackbar(context, AppText.networkErrorMessage);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _storage.deleteAll();
    accessToken.value = '';
    accessInput.value = '';
    Get.offAllNamed('/login');
  }
}
