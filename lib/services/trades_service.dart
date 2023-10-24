import 'package:peanut/api/dio.dart';
import 'package:peanut/api/api_config.dart';
import 'package:peanut/models/trade_model.dart';

class TradesService {
  Future<List<TradeModel>> getUserTrades(String accessToken, String login) async {
    try {
      final response = await DioClient.dio.post(
        '${ApiConfig.baseUrl}/GetOpenTrades',
        data: {
          "login": login,
          "token": accessToken,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> tradeDataList = response.data;
        final List<TradeModel> trades = tradeDataList
            .map((tradeData) => TradeModel(
          currentPrice: tradeData['currentPrice'],
          comment: tradeData['comment'],
          digits: tradeData['digits'],
          login: tradeData['login'],
          openPrice: tradeData['openPrice'],
          openTime: tradeData['openTime'],
          profit: tradeData['profit'],
          sl: tradeData['sl'],
          swaps: tradeData['swaps'],
          symbol: tradeData['symbol'],
          tp: tradeData['tp'],
          ticket: tradeData['ticket'],
          type: tradeData['type'],
          volume: tradeData['volume'],
        ))
            .toList();

        return trades;
      } else {
        throw 'Unable to fetch user trades';
      }
    } catch (e) {
      throw 'Error: $e';
    }
  }
}
