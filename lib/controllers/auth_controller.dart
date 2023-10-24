import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:peanut/views/profile_view.dart';
import 'package:peanut/views/dashboard_view.dart';
import 'package:peanut/views/trade_list_view.dart';
import 'package:peanut/models/trade_model.dart';
import 'package:peanut/models/auth_model.dart';
import 'package:peanut/api/api_config.dart';

class AuthController extends GetxController {
  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final Connectivity _connectivity = Connectivity();

  final AuthModel authModel = AuthModel(login: '2088888', password: 'ral11lod');
  final RxString accessToken = ''.obs;
  final String accessTokenKey = 'access_token';
  final String tokenExpirationKey = 'token_expiration';

  final RxBool isLoading = false.obs;
  final RxList<TradeModel> userTradesList = <TradeModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    final storedToken = await _storage.read(key: accessTokenKey);
    final isExpired =
        storedToken != null ? await isTokenExpired(storedToken) : true;

    if (!isExpired) {
      accessToken.value = storedToken;
      Get.off(DashboardPage()); // Redirect to the dashboard
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
            backgroundColor: Colors.red, colorText: Colors.white);
        isLoading.value = false;
        return;
      }

      final response = await _dio.post(
        '${ApiConfig.baseUrl}/IsAccountCredentialsCorrect',
        // data: {
        //   "login": login,
        //   "password": password,
        // },

        //todo remove
        data: {
          "login": authModel.login,       // Use the testing login
          "password": authModel.password, // Use the testing password
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        if (data['result'] == true) {
          // Store credentials securely
          await _storage.write(key: accessTokenKey, value: data['token']);

          // Record token expiration time
          final currentTime = DateTime.now();
          final tokenExpiration = currentTime.add(Duration(
              minutes: 30)); // Replace with actual token expiration time
          await _storage.write(
              key: tokenExpirationKey,
              value: tokenExpiration.toIso8601String());

          accessToken.value = data['token'];
        //  Get.to(ProfileView());
         // Get.to(DashboardPage());
          Get.toNamed('/dashboard');
        } else {
          Get.snackbar('Login Failed', 'Incorrect login or password.',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else if (response.statusCode == 401) {
        Get.snackbar('Login Failed', 'Unauthorized access.',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else if (response.statusCode == 500) {
        Get.snackbar('Server Error', 'Internal server error occurred.',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        Get.snackbar('Error', 'Network error occurred.',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error occurred.',
          backgroundColor: Colors.red, colorText: Colors.white);
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: accessTokenKey);
    await _storage.delete(key: tokenExpirationKey);
    accessToken.value = '';
    // Navigate to the login page
    Get.offAllNamed('/login');
  }
}
