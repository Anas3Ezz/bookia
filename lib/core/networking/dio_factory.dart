import 'package:bookia/core/helper/storge_services.dart';
import 'package:bookia/core/networking/api_constants.dart';
import 'package:dio/dio.dart';

class DioFactory {
  static Dio? dio;

  static Future<void> initDio() async {
    final String? token = StorageService.getToken();

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
  }

  static void updateToken(String token) {
    dio?.options.headers['Authorization'] = 'Bearer $token';
  }
}
