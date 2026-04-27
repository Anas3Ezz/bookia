import 'package:bookia/core/helper/storage_services.dart';
import 'package:bookia/core/networking/api_constants.dart';
import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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

    _add401Interceptor(dio!);
  }

  static void updateToken(String token) {
    dio?.options.headers['Authorization'] = 'Bearer $token';
  }

  // ─────────────────────────────────────────────
  // 401 Interceptor
  // ─────────────────────────────────────────────

  static void _add401Interceptor(Dio dio) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await StorageService.removeToken();
            _showSessionExpiredDialog();
          }
          handler.next(error);
        },
      ),
    );
  }

  static void _showSessionExpiredDialog() {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    // avoid showing dialog multiple times if multiple requests fail at once
    if (ModalRoute.of(context)?.settings.name == AppRoutes.login) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Session Expired'),
        content: const Text(
          'Your session has ended. Please log in again to continue.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              navigatorKey.currentState?.pushNamedAndRemoveUntil(
                AppRoutes.login,
                (route) => false,
              );
            },
            child: const Text(
              'Login Again',
              style: TextStyle(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
