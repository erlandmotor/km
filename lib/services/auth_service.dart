import 'dart:convert';

import 'package:adamulti_mobile_clone_new/constant/constant.dart';
import 'package:adamulti_mobile_clone_new/function/custom_function.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/model/account_kit_response.dart';
import 'package:adamulti_mobile_clone_new/model/change_pin_response.dart';
import 'package:adamulti_mobile_clone_new/model/check_firebase_email_response.dart';
import 'package:adamulti_mobile_clone_new/model/decrypt_result_response.dart';
import 'package:adamulti_mobile_clone_new/model/getme_response.dart';
import 'package:adamulti_mobile_clone_new/model/login_response.dart';
import 'package:adamulti_mobile_clone_new/model/otp_response.dart';
import 'package:adamulti_mobile_clone_new/model/register_response.dart';
import 'package:adamulti_mobile_clone_new/model/user_appid.dart';
import 'package:adamulti_mobile_clone_new/services/jwt_service.dart';
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

  GoogleSignInAccount? getCurrentSigningAccount() {
    final currentSigning = _googleSignIn.currentUser;
    return currentSigning;
  }

  Future<RegisterResponse> registerAccount(
    String uuid,
    String pin,
    String name,
    String namaPemilik,
    String address,
    String phone,
    String email,
    int province,
    int city,
    int district,
    String? upline
  ) async {
    final hash = md5.convert(utf8.encode("8A43D1931B899AD9D40993DF71D5DFF2$uuid")).toString();
    final response = await _dio.post("$baseUrlCore/register", data: {
      "uuid": uuid,
      "pin": pin,
      "namatoko": name,
      "nama": namaPemilik,
      "alamat": address,
      "nohp": phone,
      "email": email,
      "province_id": province,
      "city_id": city,
      "district_id": district,
      "zipcode": "",
      "upline": upline,
      "koordinat": ""
    }, options: Options(
      headers: {
        'x-auth-irs': hash
      },
    ));

    return RegisterResponse.fromJson(response.data);
  }

  Future<CheckFirebaseEmailResponse> checkFirebaseEmail(String email) async {
    final response = await _dio.post("$baseUrlAuth/firebase-backend/email", data: {
      "email": email
    });

    return CheckFirebaseEmailResponse.fromJson(response.data);
  }

  void clearGoogleSigning() {
    final currentSignedUser = _googleSignIn.currentUser;
    if(currentSignedUser != null) {
      _googleSignIn.signOut();
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

  Future<OtpResponse> sendOtp(String uuid, String phoneNumber, String message) async {
    final hash = md5.convert(utf8.encode("8A43D1931B899AD9D40993DF71D5DFF2$uuid")).toString();

    final response = await _dio.post("$baseUrlCore/otp/wa", 
    data: {
      "uuid": uuid,
      "phone": phoneNumber,
      "message": message,
      "hp": phoneNumber
    },
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': hash
      },
    ));

    return OtpResponse.fromJson(response.data);
  }

  Future<OtpResponse> cekExisting(String uuid, String phoneNumber) async {
    final hash = md5.convert(utf8.encode("8A43D1931B899AD9D40993DF71D5DFF2$uuid")).toString();

    final response = await _dio.post("$baseUrlCore/cekregister?uuid=$uuid&hp=$phoneNumber",
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': hash
      },
    ));

    return OtpResponse.fromJson(response.data);
  }

  Future<OtpResponse> cekPin(String uuid, String pin) async {
    final hash = md5.convert(utf8.encode("8A43D1931B899AD9D40993DF71D5DFF2$uuid")).toString();

    final response = await _dio.post("$baseUrlCore/cekpin",
    data: {
      "uuid": uuid,
      "pin": pin
    },
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': hash
      },
    ));

    return OtpResponse.fromJson(response.data);
  }

  Future<GetMeResponse> getMe(String uuid) async {
    final hash = md5.convert(utf8.encode("8A43D1931B899AD9D40993DF71D5DFF2$uuid")).toString();
    final response = await _dio.get("$baseUrlCore/getme?uuid=$uuid",
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': hash
      },
    ));

    return GetMeResponse.fromJson(response.data);
  }

  Future<AccountKitResponse> accountKit(String uuid, String phone, String pin) async {
    final hash = md5.convert(utf8.encode("8A43D1931B899AD9D40993DF71D5DFF2$uuid")).toString();
    final encryptedPin = encryptAes256(pin);
    final response = await _dio.post("$baseUrlCore/accountKit",
    data: {
      "uuid": uuid,
      "phone": phone,
      "pin": encryptedPin
    },
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': hash
      },
    ));

    return AccountKitResponse.fromJson(response.data);
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
    final response = await _dio.post("$baseUrlAuth/auth/tpyrced-token", 
      data: {
        "uuid": uuid
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
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

  Future<ChangePinResponse> changePin(String uuid, String pinlama, String pinBaru,
  String pinConfirmation) async {
    final decodeTokenResult = await locator.get<JwtService>().decodeToken();

    final response = await _dio.post("$baseUrlCore/gantipin", 
    data: {
      "uuid": uuid,
      "pinlama": pinlama,
      "pinbaru": pinBaru,
      "pinconf": pinConfirmation
    },
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'x-auth-irs': decodeTokenResult
      },
    ));

    return ChangePinResponse.fromJson(response.data);
  }
}