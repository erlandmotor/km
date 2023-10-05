import 'package:adamulti_mobile_clone_new/constant/constant.dart';
import 'package:adamulti_mobile_clone_new/function/custom_function.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/model/transaction_response.dart';
import 'package:adamulti_mobile_clone_new/services/jwt_service.dart';
import 'package:dio/dio.dart';

class TransactionService {
  final _dio = Dio();

  Future<TransactionResponse> payNow(String kodeProduk, String tujuan,
  String pin, String uuid) async {
    final decodeTokenResult = await locator.get<JwtService>().decodeToken();
    
    final idtrx = generateRandomString(8);

    final response = await _dio.post("$baseUrlCore/trx", data: {
      "uuid": uuid,
      "kodeproduk": kodeProduk,
      "idtrx": idtrx,
      "pin": pin,
      "tujuan": tujuan,
    }, options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': decodeTokenResult
      },
    ));

    return TransactionResponse.fromJson(response.data);
  }

  Future<TransactionResponse> checkIdentity(String kodeProduk, String tujuan,
  String jenis, String uuid) async {
    final decodeTokenResult = await locator.get<JwtService>().decodeToken();
    
    final idtrx = generateRandomString(8);

    final response = await _dio.post("$baseUrlCore/trx", data: {
      "uuid": uuid,
      "kodeproduk": kodeProduk,
      "idtrx": idtrx,
      "jenis": jenis,
      "tujuan": tujuan,
    }, options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': decodeTokenResult
      },
    ));

    return TransactionResponse.fromJson(response.data);
  }
}