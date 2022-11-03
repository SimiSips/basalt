class StockModel {
  final String name;
  final String symbol;
  final String exName;
  final String acronym;
  final String mic;
  final String country;
  final String city;

  StockModel({
    required this.name,
    required this.symbol,
    required this.exName,
    required this.acronym,
    required this.mic,
    required this.country,
    required this.city
});

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
        name: json['name'],
        symbol: json['symbol'],
        exName: json['stock_exchange']['name'],
        acronym: json['stock_exchange']['acronym'],
        mic: json['stock_exchange']['mic'],
        country: json['stock_exchange']['country'],
        city: json['stock_exchange']['city']
    );
  }
}