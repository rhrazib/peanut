import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peanut/controllers/auth_controller.dart';
import 'package:peanut/controllers/trades_controller.dart';
import 'package:peanut/models/trade_model.dart';

class TradeListView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final TradesController tradesController = Get.find<TradesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Trades'),
      ),
      body: FutureBuilder<List<TradeModel>>(
        future: tradesController.fetchUserTrades(authController.accessToken.value, authController.accessInput.value),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final userTrades = snapshot.data;

            return RefreshIndicator(
              onRefresh: () async {
                await tradesController.fetchUserTrades(authController.accessToken.value, authController.accessInput.value);
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Total Profit: \$${tradesController.totalProfit.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: userTrades!.length,
                      itemBuilder: (context, index) {
                        final trade = userTrades[index];
                        return Card(
                          elevation: 4, // Add shadow to the card
                          margin: EdgeInsets.all(8), // Add margin around the card
                          child: ListTile(
                            title: Text(
                              'Symbol: ${trade.symbol}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Profit: ${trade.profit?.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: trade.profit! > 0 ? Colors.green : Colors.red, // Color based on profit
                              ),
                            ),
                            trailing: Text(
                              'Type: ${trade.type == 0 ? 'Sell' : 'Buy'}',
                              style: TextStyle(
                                color: trade.type == 0 ? Colors.red : Colors.green, // Color based on trade type
                              ),
                            ),
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
