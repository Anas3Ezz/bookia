import 'package:bookia/core/networking/api_constants.dart';
import 'package:dio/dio.dart';

class DioFactory {
  static Dio? dio;

  static void initDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: Duration(seconds: 10),
      ),
    );
  }
}
