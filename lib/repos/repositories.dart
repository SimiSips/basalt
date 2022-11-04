import 'dart:convert';
import 'package:basalt/models/stock_model.dart';
import 'package:http/http.dart';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';



Random random = new Random();
int randomNumber = random.nextInt(100);
final api_key = dotenv.env['ACCESS_KEY'];

class StockRepository {

  String url = 'http://api.marketstack.com/v1/tickers?access_key=$api_key&limit=10&offset=${randomNumber}';
  Future<List<StockModel>> getStocks() async {
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200){
      final List result = jsonDecode(response.body)['data'];
      return result.map(((e) => StockModel.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}