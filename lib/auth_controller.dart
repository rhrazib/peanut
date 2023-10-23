import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:peanut/profile_view.dart';
import 'auth_model.dart';
import 'api_config.dart';

class AuthController extends GetxController {
  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final Connectivity _connectivity = Connectivity();

  final AuthModel authModel = AuthModel(login: '2088888', password: 'ral11lod');
  final RxString accessToken = ''.obs;
  final String accessTokenKey = 'access_token';

  final RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    final storedToken = await _storage.read(key: accessTokenKey);
    if (storedToken != null) {
      accessToken.value = storedToken;
    }
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
        data: {
          "login": login,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        if (data['result'] == true) {
          accessToken.value = data['token'];
          await _storage.write(key: accessTokenKey, value: data['token']);

          Get.to(ProfileView());
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
    accessToken.value = '';
  }

  Future<Map<String, dynamic>> getAccountInformation() async {
    try {
      final response = await _dio.post(
        '${ApiConfig.baseUrl}/GetAccountInformation',
        data: {
          "login": authModel.login,
          "token": accessToken.value,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        return data;
      }

      throw 'Unable to fetch account information';
    } catch (e) {
      throw 'Error: $e';
    }
  }

  Future<String> getLastFourNumbersPhone() async {
    try {
      final response = await _dio.post(
        '${ApiConfig.baseUrl}/GetLastFourNumbersPhone',
        data: {
          "login": authModel.login,
          "token": accessToken.value,
        },
      );

      if (response.statusCode == 200) {
        final String lastFourNumbers = response.data;
        return lastFourNumbers; // Successfully fetched the last four numbers.
      } else {
        throw 'Unable to fetch last four numbers';
      }
    } catch (e) {
      throw 'Error: $e';
    }
  }
}
