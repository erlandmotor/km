import 'package:adamulti_mobile_clone_new/constant/constant.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/model/main_menu_mobile.dart';
import 'package:adamulti_mobile_clone_new/model/setting_kategori_response.dart';
import 'package:adamulti_mobile_clone_new/services/secure_storage.dart';
import 'package:dio/dio.dart';

class BackOfficeService {
  final _dio = Dio();

  Future<List<SettingKategoriResponse>> getSettingKategoriByKategori(String kategori) async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");

    final response = await _dio.post("$baseUrlAuth/setting-kategori/kategori/many", data: {
      "kategori": kategori
    }, options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      }
    ));

    return (response.data as List).map((e) => SettingKategoriResponse.fromJson(e)).toList();
  }

  Future<List<MainMenuMobile>> getMainMenuMobile() async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");

    final response = await _dio.get("$baseUrlAuth/menu-mobile/many", options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      }
    ));

    return (response.data as List).map((e) => MainMenuMobile.fromJson(e)).toList();
  }

  
}