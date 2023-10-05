import 'dart:math';

import 'package:intl/intl.dart';

String convertNumberStringToAsterisk(String countedString) {
  final lenCountedString = countedString.length;
  var asteriskString = '';
  for(var i = 0; i < lenCountedString; i++) {
    asteriskString += '*';
  }

  return asteriskString;
}

class FormatCurrency {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: decimalDigit
    );

    return currencyFormat.format(number);
  }
}

String generateRandomString(int len) {
  var r = Random();
  const chars = '1234567890';
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}