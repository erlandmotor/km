import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/notification_paginate_response.dart";
import "package:adamulti_mobile_clone_new/services/secure_storage.dart";
import "package:dio/dio.dart";
import 'package:adamulti_mobile_clone_new/constant/constant.dart';

class NotificationService {

  final _dio = Dio();

  Future<int> countTotalNotification(String fromDate, String toDate) async {

    final token = await locator.get<SecureStorageService>().readSecureData("jwt");

    final response = await _dio.post("$baseUrlAuth/notification/count-date", 
    data: {
      "from_date": fromDate,
      "to_date": toDate
    },
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      }
    ));

    return int.parse(response.data);
  }

  Future<NotificationPaginateResponse> paginate(int page) async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");
    
    final response = await _dio.get("$baseUrlAuth/notification/paginate?page=$page",
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      }
    ));

    return NotificationPaginateResponse.fromJson(response.data);
  }

  Future<NotificationData> findUnique(int id) async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");
    
    final response = await _dio.get("$baseUrlAuth/notification/$id",
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      }
    ));

    return NotificationData.fromJson(response.data);
  }
}