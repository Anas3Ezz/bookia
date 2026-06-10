import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookia/core/helper/storage_services.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/feature/profile/cubit/profile_cubit.dart';

class MockDio extends Mock implements Dio {}

// ---------------------------------------------------------------------------
// Fixtures
// ---------------------------------------------------------------------------

Response<dynamic> _profileOk() => Response(
      data: {
        'status': 200,
        'message': 'ok',
        'data': {
          'id': 1,
          'name': 'Alice',
          'email': 'alice@example.com',
          'address': '123 Main St',
          'city': 'Cairo',
          'phone': '01234567890',
          'email_verified': true,
          'image': 'https://example.com/alice.jpg',
        },
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );

Response<dynamic> _error() => Response(
      data: null,
      statusCode: 500,
      requestOptions: RequestOptions(path: ''),
    );

void main() {
  late MockDio mockDio;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() async {
    mockDio = MockDio();
    DioFactory.dio = mockDio;
    // Stub options so logout can access headers
    final opts = BaseOptions(headers: <String, dynamic>{});
    when(() => mockDio.options).thenReturn(opts);
    // Initialize SharedPreferences mock for logout (StorageService.removeToken)
    SharedPreferences.setMockInitialValues({});
    await StorageService.init();
  });

  tearDown(() {
    DioFactory.dio = null;
  });

  group('ProfileCubit – getProfile', () {
    blocTest<ProfileCubit, ProfileState>(
      'emits [GetProfileLoading, GetProfileSuccess] on 200 response',
      build: () {
        when(() => mockDio.get(any())).thenAnswer((_) async => _profileOk());
        return ProfileCubit();
      },
      act: (cubit) => cubit.getProfile(),
      expect: () => [isA<GetProfileLoading>(), isA<GetProfileSuccess>()],
    );

    blocTest<ProfileCubit, ProfileState>(
      'GetProfileSuccess carries the parsed profile data',
      build: () {
        when(() => mockDio.get(any())).thenAnswer((_) async => _profileOk());
        return ProfileCubit();
      },
      act: (cubit) => cubit.getProfile(),
      expect: () => [
        isA<GetProfileLoading>(),
        isA<GetProfileSuccess>().having(
          (s) => s.profile.name,
          'name',
          'Alice',
        ),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits [GetProfileLoading, GetProfileError] on non-200 response',
      build: () {
        when(() => mockDio.get(any())).thenAnswer((_) async => _error());
        return ProfileCubit();
      },
      act: (cubit) => cubit.getProfile(),
      expect: () => [isA<GetProfileLoading>(), isA<GetProfileError>()],
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits [GetProfileLoading, GetProfileError] when get throws',
      build: () {
        when(() => mockDio.get(any())).thenThrow(Exception('Timeout'));
        return ProfileCubit();
      },
      act: (cubit) => cubit.getProfile(),
      expect: () => [isA<GetProfileLoading>(), isA<GetProfileError>()],
    );
  });

  group('ProfileCubit – logout', () {
    blocTest<ProfileCubit, ProfileState>(
      'emits [LogoutLoading, LogoutSuccess] when logout succeeds',
      build: () => ProfileCubit(),
      act: (cubit) => cubit.logout(),
      expect: () => [isA<LogoutLoading>(), isA<LogoutSuccess>()],
    );
  });

  group('ProfileCubit – initial state', () {
    test('is ProfileInitial', () {
      final cubit = ProfileCubit();
      expect(cubit.state, isA<ProfileInitial>());
      cubit.close();
    });
  });
}
