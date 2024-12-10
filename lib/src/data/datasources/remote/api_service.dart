import 'package:dio/dio.dart';
import 'package:calculator_app/src/data/models/currency.dart';

class ApiService {
  static const String baseUrl = 'https://cbu.uz/uz/arkhiv-kursov-valyut/json/';

  Dio getDio() => Dio();

  Future<List<Currency>> getCurrencyRates() async {
    try {
      Response response = await getDio().get(baseUrl);
      List<Currency> currencies = [];
      for (var item in response.data) {
        currencies.add(Currency.fromJson(item));
      }
      return currencies;
    } catch (e) {
      rethrow;
    }
  }
}
