import 'package:adamulti_mobile_clone_new/constant/constant.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/model/artikel_data.dart';
import 'package:adamulti_mobile_clone_new/model/carousel_data.dart';
import 'package:adamulti_mobile_clone_new/model/find_first_operator_setting_response.dart';
import 'package:adamulti_mobile_clone_new/model/kategori_with_menu_response.dart';
import 'package:adamulti_mobile_clone_new/model/main_menu_mobile.dart';
import 'package:adamulti_mobile_clone_new/model/popup_response.dart';
import 'package:adamulti_mobile_clone_new/model/setting_applikasi_response.dart';
import 'package:adamulti_mobile_clone_new/model/setting_kategori_response.dart';
import 'package:adamulti_mobile_clone_new/services/secure_storage.dart';
import 'package:dio/dio.dart';

class BackOfficeService {
  final _dio = Dio();

  Future<List<ArtikelData>> findManyArtikel() async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");

    final response = await _dio.get("$baseUrlAuth/berita/many", options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      }
    ));

    return (response.data as List).map((e) => ArtikelData.fromJson(e)).toList();
  }

  Future<List<ArtikelData>> findManyArtikelByStatus(int status) async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");

    final response = await _dio.get("$baseUrlAuth/berita/many-status?status=$status", options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      }
    ));

    return (response.data as List).map((e) => ArtikelData.fromJson(e)).toList();
  }

  Future<ArtikelData> findUniqueArtikel(int id) async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");

    final response = await _dio.get("$baseUrlAuth/berita/$id", options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      }
    ));

    return ArtikelData.fromJson(response.data);
  }

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

  Future<KategoriWithMenuResponse> getSpecificMenuByKategori(int id) async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");

    final response = await _dio.get("$baseUrlAuth/setting-menu-kategori/with-menu/specific/$id", options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      }
    ));

    return KategoriWithMenuResponse.fromJson(response.data);
  }

  Future<FindFirstOperatorSettingResponse> findFirstOperatorSettings(String operatorName) async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");

    final response = await _dio.get("$baseUrlAuth/operator/first/$operatorName", options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      }
    ));

    return FindFirstOperatorSettingResponse.fromJson(response.data);
  }
  
  Future<List<KategoriWithMenuResponse>> getAllMenuByKategoriExclude(int id, int id2) async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");

    final response = await _dio.get("$baseUrlAuth/setting-menu-kategori/with-menu/exclude/$id/$id2", options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      }
    ));

    return (response.data as List).map((e) => KategoriWithMenuResponse.fromJson(e)).toList();
  }

  Future<PopupResponse> getPopupImage() async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");

    final response = await _dio.get("$baseUrlAuth/setting-popup/1", options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      }
    ));

    return PopupResponse.fromJson(response.data);
  }

  Future<List<CarouselData>> getCarouselImage() async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");

    final response = await _dio.get("$baseUrlAuth/carousel/many-kategori/MPN", options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      }
    ));

    return (response.data as List).map((e) => CarouselData.fromJson(e)).toList();
  }
  
  Future<SettingApplikasiResponse> findFirstSettingApplikasi(String kategori) async {

    final response = await _dio.get("$baseUrlAuth/setting-applikasi/first/$kategori", options: Options(
      headers: {
        'Content-Type': 'application/json',
      }
    ));

    return SettingApplikasiResponse.fromJson(response.data);
  }
}