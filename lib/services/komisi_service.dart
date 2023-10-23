import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/model/komisi_history_response.dart';
import 'package:adamulti_mobile_clone_new/services/jwt_service.dart';
import 'package:dio/dio.dart';
import 'package:adamulti_mobile_clone_new/constant/constant.dart';

class KomisiService {

  final _dio = Dio();

  Future<KomisiHistoryResponse> getHistoryKomisi(
    String uuid,
    String count,
    String cari,
    String page,
    String tanggalAwal,
    String tanggalAkhir
  ) async {
    final decodeTokenResult = await locator.get<JwtService>().decodeToken();

    final response = await _dio.get("$baseUrlCore/komisi?uuid=$uuid&count=$count&cari=$cari&page=$page&tanggalawal=$tanggalAwal&tanggalakhir=$tanggalAkhir", 
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': decodeTokenResult
      },
    ));

    return KomisiHistoryResponse.fromJson(response.data);
  }
}