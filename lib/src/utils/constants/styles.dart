import 'package:calculator_app/src/services/calculator_service.dart';
import 'package:calculator_app/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static TextStyle historyStyle(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      fontSize: mediaQuery.devicePixelRatio * 6,
      color: AppColors.grey,
    );
  }

  TextStyle titleStyle(String symbol, BuildContext context) {
    bool isNumber = CalculatorService.isNumber(symbol);

    MediaQueryData mediaQuery = MediaQuery.of(context);

    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      fontSize: mediaQuery.devicePixelRatio * 12,
      color: isNumber ? AppColors.black : AppColors.red,
    );
  }
}
