class TradeModel {
  final double currentPrice;
  final String? comment;
  final int digits;
  final int login;
  final double openPrice;
  final String openTime;
  final double profit;
  final double? sl;
  final double? swaps;
  final String symbol;
  final double? tp;
  final int ticket;
  final int type;
  final double? volume;

  TradeModel({
    required this.currentPrice,
    this.comment,
    required this.digits,
    required this.login,
    required this.openPrice,
    required this.openTime,
    required this.profit,
    this.sl,
    this.swaps,
    required this.symbol,
    this.tp,
    required this.ticket,
    required this.type,
    this.volume,
  });
}
