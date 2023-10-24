import 'package:get/get.dart';
import 'package:peanut/models/trade_model.dart';
import 'package:peanut/services/trades_service.dart';

class TradesController extends GetxController {
  final tradesService = TradesService();

  final RxList<TradeModel> userTradesList = <TradeModel>[].obs;
  final RxDouble totalProfit = RxDouble(0.0);

  Future<void> fetchUserTrades(String accessToken, String login) async {
    try {
      final trades = await tradesService.getUserTrades(accessToken, login);
      userTradesList.assignAll(trades);

      // Calculate total profit
      final total = trades.fold<double>(0.0, (sum, trade) => sum + (trade.profit ?? 0));
      totalProfit.value = total;
    } catch (e) {
      throw 'Error: $e';
    }
  }
}
