import 'package:flutter/material.dart';

const baseUrlAuth = "http://wan1.adamulti.com:8999/api";
const baseUrlCore = "http://wan1.adamulti.com:90/apps/v9";
const baseUrlV8 = "http://wan1.adamulti.com:90/apps/v8";

const kMainThemeColor = Color(0xff192a56);
const kSecondaryColor = Color(0xff273c75);
const kStatusbarColor = Color(0xff22386e);
const kMainLightThemeColor = Color(0xff4a69bd);
const kNavigationBarColor = Color(0xff273870);
const kLightBackgroundColor = Color(0xfff4f5f8);
const kProcessTransactionColor = Color(0xff38ada9);
const kWhiteBlueColor = Color(0xffdff9fb);
const kSecondaryTextColor = Color(0xff636e72);
const kDummyPasswordUser = "ADAMULTITOSHITA2202";

// Container Light Decoration
const kContainerLightDecoration = BoxDecoration(
  color: kLightBackgroundColor,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(18),
    topRight: Radius.circular(18)
  )
);

// Container Main Theme Decoration
final kContainerMainDecoration = BoxDecoration(
  gradient: const LinearGradient(
    colors: [kMainThemeColor, kSecondaryColor],
    stops: [0, 0.2],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  borderRadius: BorderRadius.circular(18)
);

// Operator Color
const kAxisColor = Color(0xff8e44ad);
const kIndosatColor = Color(0xfff39c12);
const kSmartfrenColor = Color(0xffe84393);
const kTelkomselColor = Color(0xffe74c3c);
const kXlColor = Color(0xff002bba);
const kThreeColor = Color(0xff353b48);

Color generateOperatorColor(String operatorName) {
  if(operatorName.toUpperCase().contains("XL")) {
    return kXlColor;
  } else if(operatorName.toUpperCase().contains("AXIS")) {
    return kAxisColor;
  } else if(operatorName.toUpperCase().contains("TELKOMSEL")) {
    return kTelkomselColor;
  } else if(operatorName.toUpperCase().contains("INDOSAT")) {
    return kIndosatColor;
  } else if(operatorName.toUpperCase().contains("SMARTFREN")) {
    return kSmartfrenColor;
  } else {
    return kThreeColor;
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}