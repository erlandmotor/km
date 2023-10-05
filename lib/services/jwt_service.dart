import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/services/secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class JwtService {
  Future<String> decodeToken() async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");
    final decodeToken = JwtDecoder.decode(token!);
    final result = decodeToken["passwordweb"] as String;

    return result;
  }
}