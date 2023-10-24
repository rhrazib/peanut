// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get/get.dart';
// import 'package:dio/dio.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:peanut/profile_view.dart';
// import 'package:peanut/trade_list_view.dart';
// import 'package:peanut/trade_model.dart';
// import 'auth_model.dart';
// import 'api_config.dart';
//
// class AuthController extends GetxController {
//   final Dio _dio = Dio();
//   final FlutterSecureStorage _storage = FlutterSecureStorage();
//   final Connectivity _connectivity = Connectivity();
//
//   final AuthModel authModel = AuthModel(
//       login: '2088888', password: 'ral11lod'); //2088888ral11lod
//   final RxString accessToken = ''.obs;
//   final String accessTokenKey = 'access_token';
//
//   final RxBool isLoading = false.obs;
//   final RxList<TradeModel> userTradesList = <TradeModel>[].obs;
//   final RxDouble totalProfit = RxDouble(0.0);
//   @override
//   void onInit() async {
//     super.onInit();
//     final storedToken = await _storage.read(key: accessTokenKey);
//     if (storedToken != null) {
//       accessToken.value = storedToken;
//     }
//   }
//
//   Future<bool> checkInternetConnection() async {
//     final result = await _connectivity.checkConnectivity();
//     return result != ConnectivityResult.none;
//   }
//
//   Future<void> login(String login, String password) async {
//     isLoading.value = true;
//     try {
//       final isConnected = await checkInternetConnection();
//       if (!isConnected) {
//         Get.snackbar('No Internet', 'Please check your internet connection.',
//             backgroundColor: Colors.red, colorText: Colors.white);
//         isLoading.value = false;
//         return;
//       }
//
//       final response = await _dio.post(
//         '${ApiConfig.baseUrl}/IsAccountCredentialsCorrect',
//         data: {
//           "login": login,
//           "password": password,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = response.data;
//         if (data['result'] == true) {
//           accessToken.value = data['token'];
//           await _storage.write(key: accessTokenKey, value: data['token']);
//         //  Get.to(TradesList());
//
//              Get.to(ProfileView());
//         } else {
//           Get.snackbar('Login Failed', 'Incorrect login or password.',
//               backgroundColor: Colors.red, colorText: Colors.white);
//         }
//       } else if (response.statusCode == 401) {
//         Get.snackbar('Login Failed', 'Unauthorized access.',
//             backgroundColor: Colors.red, colorText: Colors.white);
//       } else if (response.statusCode == 500) {
//         Get.snackbar('Server Error', 'Internal server error occurred.',
//             backgroundColor: Colors.red, colorText: Colors.white);
//       } else {
//         Get.snackbar('Error', 'Network error occurred.',
//             backgroundColor: Colors.red, colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Network error occurred.',
//           backgroundColor: Colors.red, colorText: Colors.white);
//       print('Error: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> logout() async {
//     await _storage.delete(key: accessTokenKey);
//     accessToken.value = '';
//   }
//
//   Future<Map<String, dynamic>> getAccountInformation() async {
//     try {
//       final response = await _dio.post(
//         '${ApiConfig.baseUrl}/GetAccountInformation',
//         data: {
//           "login": authModel.login,
//           "token": accessToken.value,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = response.data;
//         Get.to(TradesList());
//         return data;
//       }
//
//       throw 'Unable to fetch account information';
//     } catch (e) {
//       throw 'Error: $e';
//     }
//   }
//
//   Future<String> getLastFourNumbersPhone() async {
//     try {
//       final response = await _dio.post(
//         '${ApiConfig.baseUrl}/GetLastFourNumbersPhone',
//         data: {
//           "login": authModel.login,
//           "token": accessToken.value,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final String lastFourNumbers = response.data;
//         return lastFourNumbers; // Successfully fetched the last four numbers.
//       } else {
//         throw 'Unable to fetch last four numbers';
//       }
//     } catch (e) {
//       throw 'Error: $e';
//     }
//   }
//
//   Future<List<TradeModel>> getUserTrades() async {
//     try {
//       final response = await _dio.post(
//         '${ApiConfig.baseUrl}/GetOpenTrades',
//         data: {
//           "login": authModel.login,
//           "token": accessToken.value,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final List<dynamic> tradesData = response.data;
//         final List<TradeModel> userTrades = tradesData
//             .map((trade) => TradeModel(
//           currentPrice: trade['currentPrice'],
//           comment: trade['comment'],
//           digits: trade['digits'],
//           login: trade['login'],
//           openPrice: trade['openPrice'],
//           openTime: trade['openTime'],
//           profit: trade['profit'],
//           sl: trade['sl'],
//           swaps: trade['swaps'],
//           symbol: trade['symbol'],
//           tp: trade['tp'],
//           ticket: trade['ticket'],
//           type: trade['type'],
//           volume: trade['volume'],
//         ))
//             .toList();
//       // Calculate total profit
//               final double profitSum = userTrades.fold(0.0, (sum, trade) => sum + (trade.profit ?? 0.0));
//               totalProfit.value = profitSum;
//
//               userTradesList.value = userTrades;
//         return userTrades;
//       }
//
//       throw 'Unable to fetch user trades';
//     } catch (e) {
//       throw 'Error: $e';
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:peanut/views/profile_view.dart';
import 'package:peanut/views/trade_list_view.dart';
import 'package:peanut/models/trade_model.dart';
import 'package:peanut/models/auth_model.dart';
import 'package:peanut/api_config.dart';

class AuthController extends GetxController {
  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final Connectivity _connectivity = Connectivity();

  final AuthModel authModel = AuthModel(
    login: '2088888',
    password: 'ral11lod',
  );
  final RxString accessToken = ''.obs;
  final String accessTokenKey = 'access_token';

  final RxBool isLoading = false.obs;
  final RxList<TradeModel> userTradesList = <TradeModel>[].obs;
  final RxDouble totalProfit = RxDouble(0.0);

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
          // Get.to(TradesList());
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
         Get.to(TradesList());
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

  Future<List<TradeModel>> getUserTrades() async {
    try {
      final response = await _dio.post(
        '${ApiConfig.baseUrl}/GetOpenTrades',
        data: {
          "login": authModel.login,
          "token": accessToken.value,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> tradesData = response.data;
        final List<TradeModel> userTrades = tradesData
            .map((trade) => TradeModel(
          currentPrice: trade['currentPrice'],
          comment: trade['comment'],
          digits: trade['digits'],
          login: trade['login'],
          openPrice: trade['openPrice'],
          openTime: trade['openTime'],
          profit: trade['profit'],
          sl: trade['sl'],
          swaps: trade['swaps'],
          symbol: trade['symbol'],
          tp: trade['tp'],
          ticket: trade['ticket'],
          type: trade['type'],
          volume: trade['volume'],
        ))
            .toList();

        // Calculate total profit
        final double profitSum = userTrades.fold(0.0,
                (sum, trade) => sum + (trade.profit ?? 0.0));
        totalProfit.value = profitSum;

        userTradesList.value = userTrades;
        return userTrades;
      }

      throw 'Unable to fetch user trades';
    } catch (e) {
      throw 'Error: $e';
    }
  }
}

