
import 'package:adamulti_mobile_clone_new/constant/constant.dart';
import 'package:adamulti_mobile_clone_new/model/cities_response.dart';
import 'package:adamulti_mobile_clone_new/model/districts_response.dart';
import 'package:adamulti_mobile_clone_new/model/provinces_response.dart';
import 'package:dio/dio.dart';

class RegionService {
  final _dio = Dio();

  Future<ProvincesResponse> getProvinces() async {
    final response = await _dio.post("$baseUrlV8/locations/provinces");

    return ProvincesResponse.fromJson(response.data);
  }

  Future<CitiesResponse> getCities(int provinceId) async {
    final response = await _dio.post("$baseUrlV8/locations/cities", data: {
      "province_id": provinceId
    });

    return CitiesResponse.fromJson(response.data);
  }

  Future<DistrictsResponse> getDistricts(int cityId) async {
    final response = await _dio.post("$baseUrlV8/locations/districts", data: {
      "city_id": cityId
    });

    return DistrictsResponse.fromJson(response.data);
  }
}