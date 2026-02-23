import 'package:bookia/core/helper/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthRepo {
  static final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.loginEndpoint,
        data: {"email": email, "password": password},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<bool> register({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String name,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.registerEndpoint,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
