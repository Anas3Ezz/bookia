import 'package:bookia/core/helper/error_handler.dart';
import 'package:bookia/core/helper/storge_services.dart';
import 'package:bookia/core/networking/api_constants.dart';
import 'package:bookia/core/networking/api_result.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthRepo {
  static Future<ApiResult<bool>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiConstants.loginEndpoint,
        data: {"email": email, "password": password},
      );
      if (response?.statusCode == 200) {
        final token = response?.data['data']['token'] as String? ?? '';
        debugPrint('>>> token: $token');
        await StorageService.saveToken(token);
        DioFactory.updateToken(token);
        return const ApiResult.success(true);
      }
      return const ApiResult.failure('Login failed. Please try again.');
    } on DioException catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  static Future<ApiResult<bool>> register({
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
        final token = response?.data['data']['token'] as String? ?? '';
        debugPrint('>>> register token: $token');
        await StorageService.saveToken(token);
        DioFactory.updateToken(token);
        return const ApiResult.success(true);
      }
      return const ApiResult.failure('Registration failed. Please try again.');
    } on DioException catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  static Future<void> logout() async {
    await StorageService.removeToken();
    DioFactory.dio?.options.headers.remove('Authorization');
  }
}
