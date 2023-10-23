
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:peanut/auth_controller.dart';
// import 'package:peanut/trade_model.dart';
//
// class TradesList extends StatelessWidget {
//   final AuthController authController = Get.find<AuthController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Trades'),
//       ),
//       body: FutureBuilder<List<TradeModel>>(
//         future: authController.getUserTrades(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             final userTrades = snapshot.data;
//
//             return RefreshIndicator(
//               onRefresh: () async {
//                 await authController.getUserTrades();
//               },
//               child: ListView.builder(
//                 itemCount: userTrades!.length,
//                 itemBuilder: (context, index) {
//                   final trade = userTrades[index];
//                   return Card(
//                     child: ListTile(
//                       title: Text('Symbol: ${trade.symbol}'),
//                       subtitle: Text('Profit: ${trade.profit?.toStringAsFixed(2)}'),
//                       trailing: Text('Type: ${trade.type == 0 ? 'Sell' : 'Buy'}'),
//                       // Add more trade details as needed.
//                     ),
//                   );
//                 },
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peanut/auth_controller.dart';
import 'package:peanut/trade_model.dart';

class TradesList extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Trades'),
      ),
      body: FutureBuilder<List<TradeModel>>(
        future: authController.getUserTrades(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final userTrades = snapshot.data;

            return RefreshIndicator(
              onRefresh: () async {
                await authController.getUserTrades();
              },
              child: Column(
                children: [
                  Text('Total Profit: ${authController.totalProfit.toStringAsFixed(2)}'),
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
