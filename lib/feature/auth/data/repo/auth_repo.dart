import 'package:bookia/core/networking/api_constants.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiConstants.loginEndpoint,
        data: {"email": email, "password": password},
      );
      if (response?.statusCode == 200) {
        debugPrint(response?.data['data']['token'].toString());
        await saveToken(response?.data['data']['token'].toString() ?? '');
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
      final response = await DioFactory.dio?.post(
        ApiConstants.registerEndpoint,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );
      if (response?.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      debugPrint(e.response?.data.toString());
      return false;
    }
  }

  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
