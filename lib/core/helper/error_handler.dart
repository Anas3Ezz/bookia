import 'package:dio/dio.dart';

class ErrorHandler {
  /// Returns a human-readable error message from any exception.
  /// Works with DioException, general Exception, or unknown errors.
  static String handle(dynamic error) {
    if (error is DioException) {
      return _handleDioException(error);
    }
    return 'An unexpected error occurred. Please try again.';
  }

  static String _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return 'Connection timed out. Please check your internet and try again.';

      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';

      case DioExceptionType.badResponse:
        return _handleStatusCode(
          error.response?.statusCode,
          error.response?.data,
        );

      case DioExceptionType.cancel:
        return 'Request was cancelled.';

      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }

  static String _handleStatusCode(int? statusCode, dynamic data) {
    switch (statusCode) {
      case 400:
        return _extractMessage(data) ?? 'Bad request. Please try again.';

      case 401:
        return 'Session expired. Please login again.';

      case 403:
        return 'You do not have permission to perform this action.';

      case 404:
        return 'The requested resource was not found.';

      case 422:
        // Server returns validation errors — extract the first one
        return _extractValidationError(data) ??
            'Invalid data. Please check your input.';

      case 429:
        return 'Too many requests. Please wait and try again.';

      case 500:
      case 502:
      case 503:
        return 'Server error. Please try again later.';

      default:
        return _extractMessage(data) ??
            'Something went wrong. Please try again.';
    }
  }

  /// Extracts `message` field from API response if available
  static String? _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      final message = data['message'];
      if (message is String && message.trim().isNotEmpty) {
        return message.trim();
      }
    }
    return null;
  }

  /// Extracts the first validation error from `errors` field
  /// e.g. { "errors": { "email": ["Email already taken."] } }
  static String? _extractValidationError(dynamic data) {
    if (data is Map<String, dynamic>) {
      final errors = data['errors'];
      if (errors is Map<String, dynamic> && errors.isNotEmpty) {
        final firstField = errors.values.first;
        if (firstField is List && firstField.isNotEmpty) {
          return firstField.first.toString();
        }
      }
      // Fallback to message field
      return _extractMessage(data);
    }
    return null;
  }
}
