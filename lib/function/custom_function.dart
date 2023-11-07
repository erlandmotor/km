import 'dart:math';
import 'package:encrypt/encrypt.dart';
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

String convertTotalResponseWithNumberFormatted(String response, String totalPay) {
  final formattedTotalPay = FormatCurrency.convertToIdr(int.parse(totalPay), 0);

  final convertedResponse = response.replaceAll(totalPay, formattedTotalPay);
  return convertedResponse;
}

String encryptAes256(String plainText) {
  final key = Key.fromUtf8("26BA39CMR0YL71CFGN2RSDZRLK24SLFC");
  final iv = IV.allZerosOfLength(16);
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc,));

  final encrypted = encrypter.encrypt(plainText, iv: iv);

  return encrypted.base64;
}
