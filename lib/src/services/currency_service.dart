import 'package:calculator_app/src/data/models/currency.dart';
import 'package:calculator_app/src/data/datasources/remote/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrencyService extends StateNotifier<List<Currency>> {
  CurrencyService() : super([]);

  final apiService = ApiService();

  Future<void> getCurrencyRates() async =>
      state = await apiService.getCurrencyRates();
}

final currencyProvider = StateNotifierProvider<CurrencyService, List<Currency>>(
    (ref) => CurrencyService());
