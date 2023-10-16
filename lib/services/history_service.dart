
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/model/history_saldo_response.dart';
import 'package:adamulti_mobile_clone_new/model/history_topup_response.dart';
import 'package:adamulti_mobile_clone_new/model/history_transaksi_response.dart';
import 'package:adamulti_mobile_clone_new/model/rekap_transaksi_response.dart';
import 'package:adamulti_mobile_clone_new/services/jwt_service.dart';
import 'package:dio/dio.dart';
import 'package:adamulti_mobile_clone_new/constant/constant.dart';

class HistoryService {

  final _dio = Dio();

  Future<HistorySaldoResponse> getHistorySaldo(
    String uuid, String count, String cari, String page, String tanggalAwal,
    String tanggalAkhir
  ) async {
    final decodeTokenResult = await locator.get<JwtService>().decodeToken();

    final response = await _dio.get("$baseUrlCore/historisaldo?uuid=$uuid&count=$count&cari=$cari&page=$page&tanggalawal=$tanggalAwal&tanggalakhir=$tanggalAkhir", 
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': decodeTokenResult
      },
    ));

    return HistorySaldoResponse.fromJson(response.data);
  }

  Future<HistoryTransaksiResponse> getHistoryTransaksi(
    String uuid,
    String count,
    String cari,
    String page,
    String tanggalAwal,
    String tanggalAkhir
  ) async {
    final decodeTokenResult = await locator.get<JwtService>().decodeToken();

    final response = await _dio.get("$baseUrlCore/historitrx?uuid=$uuid&count=$count&cari=$cari&page=$page&tanggalawal=$tanggalAwal&tanggalakhir=$tanggalAkhir", 
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': decodeTokenResult
      },
    ));

    return HistoryTransaksiResponse.fromJson(response.data);
  }

  Future<RekapTransaksiResponse> getRekapTransaksi(
    String uuid,
    String tanggalAwal,
    String tanggalAkhir,
  ) async {
    final decodeTokenResult = await locator.get<JwtService>().decodeToken();

    final response = await _dio.get("$baseUrlCore/rekaptrx?uuid=$uuid&tanggalawal=$tanggalAwal&tanggalakhir=$tanggalAkhir", 
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': decodeTokenResult
      },
    ));

    return RekapTransaksiResponse.fromJson(response.data);
  }

  Future<HistoryTopupResponse> getHistoryTopup(
    String uuid,
    String count,
    String cari,
    String page,
    String tanggalAwal,
    String tanggalAkhir
  ) async {
    final decodeTokenResult = await locator.get<JwtService>().decodeToken();

    final response = await _dio.get("$baseUrlCore/historitopupdeposit?uuid=$uuid&count=$count&cari=$cari&page=$page&tanggalawal=$tanggalAwal&tanggalakhir=$tanggalAkhir", 
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': decodeTokenResult
      },
    ));

    return HistoryTopupResponse.fromJson(response.data);
  }

  Future<HistoryTopupResponse> getHistoryTransfer(
    String uuid,
    String count,
    String cari,
    String page,
    String tanggalAwal,
    String tanggalAkhir,
  ) async {
    final decodeTokenResult = await locator.get<JwtService>().decodeToken();

    final response = await _dio.get("$baseUrlCore/historitrf?uuid=$uuid&count=$count&cari=$cari&page=$page&tanggalawal=$tanggalAwal&tanggalakhir=$tanggalAkhir", 
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': decodeTokenResult
      },
    ));

    return HistoryTopupResponse.fromJson(response.data);
  }
}