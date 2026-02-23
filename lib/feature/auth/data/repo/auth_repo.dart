import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthRepo {
  static final Dio _dio = Dio();

  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        'https://codingarabic.online/api/login',
        data: {"email": email, "password": password},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      // TODO
      debugPrint(e.toString());
      return false;
    }
  }
}
