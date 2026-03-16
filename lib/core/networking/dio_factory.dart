import 'package:bookia/core/networking/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioFactory {
  static Dio? dio;

  static Future<void> initDio() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ),
    );
    debugPrint('>>> headers: ${DioFactory.dio?.options.headers}');
  }

  // Call this after login to update the token without restarting the app
  static void updateToken(String token) {
    dio?.options.headers['Authorization'] = 'Bearer $token';
  }
}
