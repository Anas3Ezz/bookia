import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bookia/core/helper/error_handler.dart';

RequestOptions _opts() => RequestOptions(path: '/test');

void main() {
  group('ErrorHandler', () {
    test('returns timeout message on connectionTimeout', () {
      final error = DioException(type: DioExceptionType.connectionTimeout, requestOptions: _opts());
      expect(ErrorHandler.handle(error), contains('timed out'));
    });

    test('returns timeout message on receiveTimeout', () {
      final error = DioException(type: DioExceptionType.receiveTimeout, requestOptions: _opts());
      expect(ErrorHandler.handle(error), contains('timed out'));
    });

    test('returns timeout message on sendTimeout', () {
      final error = DioException(type: DioExceptionType.sendTimeout, requestOptions: _opts());
      expect(ErrorHandler.handle(error), contains('timed out'));
    });

    test('returns no-internet message on connectionError', () {
      final error = DioException(type: DioExceptionType.connectionError, requestOptions: _opts());
      expect(ErrorHandler.handle(error), contains('internet'));
    });

    test('returns cancel message when request is cancelled', () {
      final error = DioException(type: DioExceptionType.cancel, requestOptions: _opts());
      expect(ErrorHandler.handle(error), contains('cancelled'));
    });

    test('returns 401 session message on 401 response', () {
      final response = Response(statusCode: 401, requestOptions: _opts());
      final error = DioException(
        type: DioExceptionType.badResponse,
        response: response,
        requestOptions: _opts(),
      );
      expect(ErrorHandler.handle(error), contains('Session expired'));
    });

    test('returns 404 message on 404 response', () {
      final response = Response(statusCode: 404, requestOptions: _opts());
      final error = DioException(
        type: DioExceptionType.badResponse,
        response: response,
        requestOptions: _opts(),
      );
      expect(ErrorHandler.handle(error), contains('not found'));
    });

    test('returns server error message on 500 response', () {
      final response = Response(statusCode: 500, requestOptions: _opts());
      final error = DioException(
        type: DioExceptionType.badResponse,
        response: response,
        requestOptions: _opts(),
      );
      expect(ErrorHandler.handle(error), contains('Server error'));
    });

    test('extracts message field from 400 response data', () {
      final response = Response(
        statusCode: 400,
        data: {'message': 'Invalid email format'},
        requestOptions: _opts(),
      );
      final error = DioException(
        type: DioExceptionType.badResponse,
        response: response,
        requestOptions: _opts(),
      );
      expect(ErrorHandler.handle(error), 'Invalid email format');
    });

    test('extracts first validation error from 422 response', () {
      final response = Response(
        statusCode: 422,
        data: {
          'errors': {
            'email': ['Email already taken.'],
          },
        },
        requestOptions: _opts(),
      );
      final error = DioException(
        type: DioExceptionType.badResponse,
        response: response,
        requestOptions: _opts(),
      );
      expect(ErrorHandler.handle(error), 'Email already taken.');
    });

    test('returns generic message for non-Dio errors', () {
      expect(ErrorHandler.handle(Exception('oops')), contains('unexpected'));
    });
  });
}
