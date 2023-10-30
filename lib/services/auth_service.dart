import 'dart:convert';

import 'package:adamulti_mobile_clone_new/constant/constant.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/model/decrypt_result_response.dart';
import 'package:adamulti_mobile_clone_new/model/login_response.dart';
import 'package:adamulti_mobile_clone_new/model/user_appid.dart';
import 'package:adamulti_mobile_clone_new/services/secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  final _dio = Dio();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    final googleAccount = await _googleSignIn.signIn();

    return googleAccount;
  }

  void clearGoogleSigning() {
    final currentSignedUser = _googleSignIn.currentUser;

    if(currentSignedUser != null) {
      _googleSignIn.disconnect();
    }
    FirebaseAuth.instance.signOut();
  }

  Future<LoginResponse> login(String idReseller) async {
    final hash = utf8.encode(idReseller);
    final response = await _dio.post("$baseUrlAuth/auth/remove-mobile", data: {
      "idreseller": idReseller
    }, options: Options(
      headers: {
        "adamulti-x": md5.convert(hash)
      },
      validateStatus: (status) {
        return status !< 500;
      }
    ));

    return LoginResponse.fromJson(response.data);
  }

  Future<LoginResponse> authenticated() async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");

    final response = await _dio.get("$baseUrlAuth/auth/authenticated", options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      },
    ));

    return LoginResponse.fromJson(response.data);
  }

  Future<UserAppid> decryptToken(String uuid, String token) async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");

    final response = await _dio.post("$baseUrlAuth/auth/tpyrced-token", 
      data: {
        "uuid": uuid
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token!}'
        },
      )
    );

    final decryptResult = (response.data as List).map((data) => DecryptResultResponse.fromJson(data)).toList();
    final mappedDecryptResult = decryptResult.map((data) {
      final decodedUnit8List = utf8.decode(data.decryptResult!.data!);
      return decodedUnit8List;
    }).toList();

    final findIndex = mappedDecryptResult.indexWhere((element) => element.contains("app:"));

    final appId = mappedDecryptResult[findIndex].replaceAll("app:", "");
    final phoneNumber = mappedDecryptResult.firstWhere((element) => element.contains("08"));

    return UserAppid(appId: appId, phone: phoneNumber);
  }
}