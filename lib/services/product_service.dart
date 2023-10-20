import 'package:adamulti_mobile_clone_new/constant/constant.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/model/get_product_by_tujuan_response.dart';
import 'package:adamulti_mobile_clone_new/model/operator_response.dart';
import 'package:adamulti_mobile_clone_new/model/product_response.dart';
import 'package:adamulti_mobile_clone_new/model/setting_operator_response.dart';
import 'package:adamulti_mobile_clone_new/services/jwt_service.dart';
import 'package:adamulti_mobile_clone_new/services/secure_storage.dart';
import 'package:dio/dio.dart';

class ProductService {
  final _dio = Dio();

  Future<OperatorResponse> getOperatorByBackoffice(String operatorName, String uuid) async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");
    final decodeTokenResult = await locator.get<JwtService>().decodeToken();

    final settingOperatorResponse = await _dio.get("$baseUrlAuth/operator/first/$operatorName", options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      }
    ));

    final settingOperator = SettingOperatorResponse.fromJson(settingOperatorResponse.data);

    final operatorResponse = await _dio.post("$baseUrlCore/getoperator", 
      data: {
        "uuid": uuid,
        "idoperator": settingOperator.listproductid
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'x-auth-irs': decodeTokenResult
        },
      )
    );

    return OperatorResponse.fromJson(operatorResponse.data);
  } 

  Future<OperatorResponse> getOperator(String uuid, String operatorId) async {
    final decodeTokenResult = await locator.get<JwtService>().decodeToken();

    final response = await _dio.post("$baseUrlCore/getoperator", 
    data: {
      "uuid": uuid,
      "idoperator": operatorId
    },
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': decodeTokenResult
      },
    ));

    return OperatorResponse.fromJson(response.data);
  }

  Future<ProductResponse> getProductByOperator(String uuid, String operatorId) async {
    final decodeTokenResult = await locator.get<JwtService>().decodeToken();

    final response = await _dio.post("$baseUrlCore/getprodukbyoperator", 
    data: {
      "uuid": uuid,
      "idoperator": operatorId
    },
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': decodeTokenResult
      },
    ));

    return ProductResponse.fromJson(response.data);
  }
  
  Future<GetProductByTujuanResponse> getProductByTujuan(String uuid, String tujuan) async {
    final decodeTokenResult = await locator.get<JwtService>().decodeToken();

    final response = await _dio.post("$baseUrlCore/getprodukbytujuan", 
    data: {
      "uuid": uuid,
      "tujuan": tujuan
    },
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': decodeTokenResult
      },
    ));

    return GetProductByTujuanResponse.fromJson(response.data);
  }
}