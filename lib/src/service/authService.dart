import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authservice {
  final Dio _dio = Dio();

  Future<void> login({
    required String username,
    required String password,
    required Function onSuccess,
    required Function(String) onError,
    required Function onFinally,
  }) async {
    final url = 'https://dev-iam.air.id/api/mobile/login';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic aWFtX21vYmlsZTo1U0tpWFpnUW9VTk1B',
    };
    final data = {
      "username": username,
      "password": password,
      "deviceInfo": {
        "brand": "Mi",
        "deviceId": "6d2c8e3dff5c1f51672",
        "model": "Redmi 9",
        "firmwareId": "OPM1.171019.026",
        "sdk": "31",
        "incremental": "V11.0.2.0.ODAMIXM",
        "codeVersion": "8.1.0",
        "fingerprint":
            "Xiaomy/rosy/rosy:8.1.0/OPM1.171019.026/V11.0.2.0.ODAMIXM:user/release-keys"
      }
    };

    try {
      final response = await _dio.post(
        url!,
        options: Options(
          headers: headers,
          contentType: Headers.jsonContentType,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        final prefs = await SharedPreferences.getInstance();

        await prefs.setString(
            'userProfile', jsonEncode(responseData['data']['userProfile']));
        await prefs.setString(
            'secretKeysOr', responseData['data']['secretKeysOr']);
        await prefs.setString('secretKey', responseData['data']['secretKey']);
        await prefs.setString(
            'accessToken', responseData['data']['access_token']);

        onSuccess();
      } else {
        onError("Username atau password salah!");
      }
    } catch (e) {
      onError("Terjadi kesalahan jaringan!");
    } finally {
      onFinally();
    }
  }
}
