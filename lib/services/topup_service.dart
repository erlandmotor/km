
import 'package:adamulti_mobile_clone_new/constant/constant.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/model/alfamart_payment_response.dart';
import 'package:adamulti_mobile_clone_new/model/setting_irma.dart';
import 'package:adamulti_mobile_clone_new/model/topup_history_response.dart';
import 'package:adamulti_mobile_clone_new/model/topup_message_response.dart';
import 'package:adamulti_mobile_clone_new/model/topup_reply_response.dart';
import 'package:adamulti_mobile_clone_new/services/jwt_service.dart';
import 'package:adamulti_mobile_clone_new/services/secure_storage.dart';
import 'package:dio/dio.dart';

class TopupService {
  final _dio = Dio();

  Future<TopupHistoryResponse> getDespositTiket(String uuid) async {
    final decodeTokenResult = await locator.get<JwtService>().decodeToken();

    final response = await _dio.get("$baseUrlCore/deposit/tiket?uuid=$uuid", options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': decodeTokenResult
      },
    ));

    return TopupHistoryResponse.fromJson(response.data);
  }

  Future<TopupReplyResponse> proceedDepositTiket(String uuid, String jumlah) async {
    final decodeTokenResult = await locator.get<JwtService>().decodeToken();
    final response = await _dio.post("$baseUrlCore/deposit/tiket", 
    data: {
      "uuid": uuid,
      "jumlah": jumlah
    },
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': decodeTokenResult
      },
    ));

    return TopupReplyResponse.fromJson(response.data);
  }

  Future<AlfamartPaymentResponse> proceedDepositTiketAlfamart(String uuid, String jumlah) async {
    final decodeTokenResult = await locator.get<JwtService>().decodeToken();
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");
    
    final settingIrmaResponse = await _dio.get("$baseUrlAuth/setting-irma/first", options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      }
    ));

    final settingIrmaData = SettingIrma.fromJson(settingIrmaResponse.data);

    final response = await _dio.post("$baseUrlCore/avianapay/alfamart", 
    data: {
      "uuid": uuid,
      "server_key": settingIrmaData.serverKey!,
      "jml": jumlah
    },
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': decodeTokenResult
      },
    ));

    return AlfamartPaymentResponse.fromJson(response.data);
  }

  
  Future<TopupMessageResponse> proceedDepositTiketOvo(String uuid, String jumlah, String hp, String serverKey) async {
    final decodeTokenResult = await locator.get<JwtService>().decodeToken();

    final response = await _dio.post("$baseUrlCore/deposit/tiket", 
    data: {
      "uuid": uuid,
      "jumlah": jumlah
    },
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': decodeTokenResult
      },
    ));

    return TopupMessageResponse.fromJson(response.data);
  }
}