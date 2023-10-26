import 'package:get/get.dart';
import 'package:peanut/models/trade_model.dart';
import 'package:peanut/services/trades_service.dart';

class TradesController extends GetxController {
  final tradesService = TradesService();

  final RxList<TradeModel> userTradesList = <TradeModel>[].obs;
  final RxDouble totalProfit = RxDouble(0.0);

  // Define exchange rates
  final double ethToUsdRate = 1810.72;
  final double eurToUsdRate = 1.059235;
  final double usdToJpyRate = 149.715;

  Future<List<TradeModel>> fetchUserTrades(
      String accessToken, String login) async {
    try {
      final trades = await tradesService.getUserTrades(accessToken, login);
      userTradesList.assignAll(trades);
      // Calculate total profit in USD
      final total = trades.fold<double>(0.0, (sum, trade) {
        // Convert profit to USD based on the symbol
        switch (trade.symbol) {
          case "#Ethereum":
            return sum + (trade.profit ?? 0) * ethToUsdRate;
          case "EURUSD":
            return sum + (trade.profit ?? 0) * eurToUsdRate;
          case "USDJPY":
            return sum + (trade.profit ?? 0) / usdToJpyRate;
          default:
            return sum;
        }
      });

      totalProfit.value = total;

      return userTradesList;
    } catch (e) {
      throw 'Error: $e';
    }
  }
}
