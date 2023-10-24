import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:peanut/auth_controller.dart';
import 'package:peanut/auth_model.dart';
import 'package:peanut/trade_model.dart';
import 'package:peanut/api_config.dart';

// class UserTradesController extends GetxController {
//   final Dio _dio = Dio();
//   final AuthModel authModel = Get.find<AuthController>().authModel;
//   final RxString accessToken = Get.find<AuthController>().accessToken;
//   final String accessTokenKey = Get.find<AuthController>().accessTokenKey;
//   final RxBool isLoading = false.obs;
//   final RxList<TradeModel> userTradesList = <TradeModel>[].obs;
//   final RxDouble totalProfit = RxDouble(0.0);
//
//   Future<void> getUserTrades() async {
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
//           profit: trade['profit'] ?? 0.0,
//           sl: trade['sl'] ?? 0.0,
//           swaps: trade['swaps'] ?? 0.0,
//           symbol: trade['symbol'],
//           tp: trade['tp'] ?? 0.0,
//           ticket: trade['ticket'],
//           type: trade['type'],
//           volume: trade['volume'] ?? 0.0,
//         ))
//             .toList();
//
//         // Calculate total profit
//         final double profitSum = userTrades.fold(0.0, (sum, trade) => sum + (trade.profit ?? 0.0));
//         totalProfit.value = profitSum;
//
//         userTradesList.value = userTrades;
//       } else {
//         throw 'Unable to fetch user trades';
//       }
//     } catch (e) {
//       throw 'Error: $e';
//     }
//   }
// }
