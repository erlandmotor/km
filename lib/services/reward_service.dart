import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/model/redeem_response.dart';
import 'package:adamulti_mobile_clone_new/model/reward_response.dart';
import 'package:adamulti_mobile_clone_new/services/jwt_service.dart';
import 'package:dio/dio.dart';
import 'package:adamulti_mobile_clone_new/constant/constant.dart';

class RewardService {
  final _dio = Dio();

  Future<RewardResponse> getHadiahList(String uuid) async {
    final decodeTokenResult = await locator.get<JwtService>().decodeToken();

    final response = await _dio.get("$baseUrlCore/hadiah?uuid=$uuid", options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': decodeTokenResult
      },
    ));

    return RewardResponse.fromJson(response.data);
  }

  Future<RewardResponse> getRewardList(String uuid) async {
    final decodeTokenResult = await locator.get<JwtService>().decodeToken();

    final response = await _dio.get("$baseUrlCore/reward?uuid=$uuid", options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': decodeTokenResult
      },
    ));

    return RewardResponse.fromJson(response.data);
  }

  Future<RedeemResponse> redeem(String uuid, String idHadiah) async {
    final decodeTokenResult = await locator.get<JwtService>().decodeToken();

    final response = await _dio.post("$baseUrlCore/hadiah/redeem", 
    data: {
      "uuid": uuid,
      "idhadiah": idHadiah
    },
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': decodeTokenResult
      },
    ));

    return RedeemResponse.fromJson(response.data);
  }
}