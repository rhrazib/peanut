import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peanut/controllers/auth_controller.dart';
import 'package:peanut/controllers/trades_controller.dart';
import 'package:peanut/models/trade_model.dart';

class TradesList extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final TradesController tradesController = Get.put(TradesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Trades'),
      ),
      body: FutureBuilder<List<TradeModel>>(
        future: tradesController.getUserTrades(authController.accessToken.value, authController.accessInput.value),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final userTrades = snapshot.data;

            return RefreshIndicator(
              onRefresh: () async {
                await tradesController.getUserTrades(authController.accessToken.value, authController.accessInput.value);
              },
              child: Column(
                children: [
                  Text('Total Profit: ${tradesController.totalProfit.toStringAsFixed(2)}'),
                  Expanded(
                    child: ListView.builder(
                      itemCount: userTrades!.length,
                      itemBuilder: (context, index) {
                        final trade = userTrades[index];
                        return Card(
                          child: ListTile(
                            title: Text('Symbol: ${trade.symbol}'),
                            subtitle: Text('Profit: ${trade.profit?.toStringAsFixed(2)}'),
                            trailing: Text('Type: ${trade.type == 0 ? 'Sell' : 'Buy'}'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
