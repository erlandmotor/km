
import 'package:adamulti_mobile_clone_new/constant/constant.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/model/topup_history_response.dart';
import 'package:adamulti_mobile_clone_new/model/topup_reply_response.dart';
import 'package:adamulti_mobile_clone_new/services/jwt_service.dart';
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

    final response = await _dio.get("$baseUrlCore/deposit/tiket", 
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
}