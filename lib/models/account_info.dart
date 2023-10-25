class AccountInformation {
  final String address;
  final double balance;
  final String city;
  final String country;
  final int currency;
  final int currentTradesCount;
  final int currentTradesVolume;
  final double equity;
  final double freeMargin;
  final bool isAnyOpenTrades;
  final bool isSwapFree;
  final int leverage;
  final String name;
  final String phone;
  final int totalTradesCount;
  final int totalTradesVolume;
  final int type;
  final int verificationLevel;
  final String zipCode;

  AccountInformation({
    required this.address,
    required this.balance,
    required this.city,
    required this.country,
    required this.currency,
    required this.currentTradesCount,
    required this.currentTradesVolume,
    required this.equity,
    required this.freeMargin,
    required this.isAnyOpenTrades,
    required this.isSwapFree,
    required this.leverage,
    required this.name,
    required this.phone,
    required this.totalTradesCount,
    required this.totalTradesVolume,
    required this.type,
    required this.verificationLevel,
    required this.zipCode,
  });

  // factory AccountInformation.fromJson(Map<String, dynamic> json) {
  //   return AccountInformation(
  //     address: json['address'] ?? '',
  //     balance: (json['balance'] ?? 0.0).toDouble(),
  //     city: json['city'] ?? '',
  //     country: json['country'] ?? '',
  //     currency: json['currency'] ?? 0,
  //     currentTradesCount: json['currentTradesCount'] ?? 0,
  //     currentTradesVolume: json['currentTradesVolume'] ?? 0,
  //     equity: (json['equity'] ?? 0.0).toDouble(),
  //     freeMargin: (json['freeMargin'] ?? 0.0).toDouble(),
  //     isAnyOpenTrades: json['isAnyOpenTrades'] ?? false,
  //     isSwapFree: json['isSwapFree'] ?? false,
  //     leverage: json['leverage'] ?? 0,
  //     name: json['name'] ?? '',
  //     phone: json['phone'] ?? '',
  //     totalTradesCount: json['totalTradesCount'] ?? 0,
  //     totalTradesVolume: json['totalTradesVolume'] ?? 0,
  //     type: json['type'] ?? 0,
  //     verificationLevel: json['verificationLevel'] ?? 0,
  //     zipCode: json['zipCode'] ?? '',
  //   );
  // }
}
