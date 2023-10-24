import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:peanut/api/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:peanut/views/profile_view.dart';
import 'package:peanut/views/dashboard_view.dart';
import 'package:peanut/views/trade_list_view.dart';
import 'package:peanut/models/trade_model.dart';
import 'package:peanut/models/auth_model.dart';
import 'package:peanut/common/utils/custom_validator.dart';
import 'package:peanut/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService authService =
      AuthService(); // Create an instance of the service

  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final Connectivity _connectivity = Connectivity();

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

    final isExpired =
        storedToken != null ? await isTokenExpired(storedToken) : true;

    if (!isExpired && loginInput != null) {
      accessToken.value = storedToken;
      accessInput.value = loginInput;
      Get.off(DashboardView()); // Redirect to the dashboard
    }
  }

  Future<bool> isTokenExpired(String token) async {
    final expiration = await _storage.read(key: tokenExpirationKey);
    if (expiration != null) {
      final expiryTime = DateTime.parse(expiration);
      final currentTime = DateTime.now();
      return currentTime.isAfter(expiryTime);
    }
    return true; // Token expiration information is missing, consider it expired.
  }

  Future<bool> checkInternetConnection() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  Future<void> login(String login, String password) async {
    isLoading.value = true;
    try {
      final isConnected = await checkInternetConnection();
      if (!isConnected) {
        Get.snackbar('No Internet', 'Please check your internet connection.',
            snackPosition: SnackPosition.BOTTOM, // Specify the position here
            backgroundColor: Colors.red,
            colorText: Colors.white);
        isLoading.value = false;
        return;
      }
      final response =
          await authService.login(login, password); // Use the service

      // final response = await DioClient.dio.post(
      //   '${ApiConfig.baseUrl}/IsAccountCredentialsCorrect',
      //   data: {
      //     "login": login,
      //     "password": password,
      //   },
      //
      //   //todo remove
      //   // data: {
      //   //   "login": authModel.login, // Use the testing login
      //   //   "password": authModel.password, // Use the testing password
      //   // },
      // );
      if (response != null) {
        final data = response;
        if (data['result'] == true) {
          // Store credentials securely
          await _storage.write(key: accessTokenKey, value: data['token']);
          await _storage.write(key: loginKey, value: login);
          // Record token expiration time
          final currentTime = DateTime.now();
          final tokenExpiration = currentTime.add(Duration(
              minutes: 30)); // Replace with actual token expiration time
          await _storage.write(
              key: tokenExpirationKey,
              value: tokenExpiration.toIso8601String());

          accessToken.value = data['token'];
          accessInput.value = login;
          //  Get.to(ProfileView());
          // Get.to(DashboardPage());
          Get.toNamed('/dashboard');
        } else if (data['result'] == false) {
          Get.snackbar('Login Failed', 'Incorrect login or password.',
              backgroundColor: Colors.red, colorText: Colors.white);
        } else {
          Get.snackbar('Login Failed', 'Incorrect login or password.',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      }
    } catch (e) {
      // todo custom showCustomSnackbar(
      //   title: "Error",
      //   message: 'Network error occurred.',
      // );

      // Get.snackbar('Error', 'Network error occurred.',
      //     snackPosition: SnackPosition.BOTTOM, // Specify the position here
      //     backgroundColor: Colors.red, colorText: Colors.white);
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: accessTokenKey);
    await _storage.delete(key: tokenExpirationKey);
    accessToken.value = '';
    Get.offAllNamed('/login');
  }
}
