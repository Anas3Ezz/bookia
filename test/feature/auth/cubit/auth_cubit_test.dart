import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookia/core/helper/storage_services.dart';
import 'package:bookia/core/networking/api_result.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/feature/auth/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/data/repo/firebase_auth_repo.dart';

class MockDio extends Mock implements Dio {}

class MockFirebaseAuthRepo extends Mock implements FirebaseAuthRepo {}

class MockUserCredential extends Mock implements UserCredential {}

// ---------------------------------------------------------------------------
// Fixtures
// ---------------------------------------------------------------------------

Response<dynamic> _loginSuccess() => Response(
      data: {
        'status': 200,
        'message': 'ok',
        'data': {'token': 'test-token-abc'},
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );

Response<dynamic> _registerSuccess() => Response(
      data: {
        'status': 201,
        'message': 'created',
        'data': {'token': 'new-token-xyz'},
      },
      statusCode: 201,
      requestOptions: RequestOptions(path: ''),
    );

Response<dynamic> _error() => Response(
      data: {'message': 'Invalid credentials'},
      statusCode: 401,
      requestOptions: RequestOptions(path: ''),
    );

void main() {
  late MockDio mockDio;
  late MockFirebaseAuthRepo mockFirebaseRepo;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() async {
    mockDio = MockDio();
    mockFirebaseRepo = MockFirebaseAuthRepo();
    DioFactory.dio = mockDio;
    final opts = BaseOptions(headers: <String, dynamic>{});
    when(() => mockDio.options).thenReturn(opts);
    SharedPreferences.setMockInitialValues({});
    await StorageService.init();
  });

  tearDown(() {
    DioFactory.dio = null;
  });

  group('AuthCubit – authLogin', () {
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoadingState, AuthSuccess] when login returns 200',
      build: () {
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => _loginSuccess());
        return AuthCubit(firebaseAuthRepo: mockFirebaseRepo);
      },
      act: (cubit) => cubit.authLogin(
        email: 'test@example.com',
        password: 'Password1',
      ),
      expect: () => [isA<AuthLoadingState>(), isA<AuthSuccess>()],
    );

    blocTest<AuthCubit, AuthState>(
      'AuthSuccess message contains welcome text on login',
      build: () {
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => _loginSuccess());
        return AuthCubit(firebaseAuthRepo: mockFirebaseRepo);
      },
      act: (cubit) =>
          cubit.authLogin(email: 'test@example.com', password: 'Password1'),
      expect: () => [
        isA<AuthLoadingState>(),
        isA<AuthSuccess>().having(
            (s) => s.message, 'message', contains('Signed in')),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoadingState, AuthFailure] when login returns non-200',
      build: () {
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => _error());
        return AuthCubit(firebaseAuthRepo: mockFirebaseRepo);
      },
      act: (cubit) =>
          cubit.authLogin(email: 'bad@example.com', password: 'wrongpass'),
      expect: () => [isA<AuthLoadingState>(), isA<AuthFailure>()],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoadingState, AuthFailure] when post throws',
      build: () {
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenThrow(DioException(
          type: DioExceptionType.connectionError,
          requestOptions: RequestOptions(path: ''),
        ));
        return AuthCubit(firebaseAuthRepo: mockFirebaseRepo);
      },
      act: (cubit) =>
          cubit.authLogin(email: 'test@example.com', password: 'Password1'),
      expect: () => [isA<AuthLoadingState>(), isA<AuthFailure>()],
    );
  });

  group('AuthCubit – authRegister', () {
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoadingState, AuthSuccess] when register returns 201',
      build: () {
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => _registerSuccess());
        return AuthCubit(firebaseAuthRepo: mockFirebaseRepo);
      },
      act: (cubit) => cubit.authRegister(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'Password1',
        passwordConfirmation: 'Password1',
      ),
      expect: () => [isA<AuthLoadingState>(), isA<AuthSuccess>()],
    );

    blocTest<AuthCubit, AuthState>(
      'AuthSuccess message contains the trimmed name on register',
      build: () {
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => _registerSuccess());
        return AuthCubit(firebaseAuthRepo: mockFirebaseRepo);
      },
      act: (cubit) => cubit.authRegister(
        name: 'John',
        email: 'john@example.com',
        password: 'Password1',
        passwordConfirmation: 'Password1',
      ),
      expect: () => [
        isA<AuthLoadingState>(),
        isA<AuthSuccess>()
            .having((s) => s.message, 'message', contains('John')),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoadingState, AuthFailure] when register returns non-201',
      build: () {
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => _error());
        return AuthCubit(firebaseAuthRepo: mockFirebaseRepo);
      },
      act: (cubit) => cubit.authRegister(
        name: 'Bad User',
        email: 'bad@example.com',
        password: 'Password1',
        passwordConfirmation: 'Password1',
      ),
      expect: () => [isA<AuthLoadingState>(), isA<AuthFailure>()],
    );
  });

  group('AuthCubit – Firebase sign-in', () {
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoadingState, AuthSuccess] when Firebase sign-in succeeds',
      build: () {
        when(() => mockFirebaseRepo.signInWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => ApiResult.success(MockUserCredential()));
        return AuthCubit(firebaseAuthRepo: mockFirebaseRepo);
      },
      act: (cubit) => cubit.signInWithEmailAndPassword(
        email: 'firebase@example.com',
        password: 'Password1',
      ),
      expect: () => [isA<AuthLoadingState>(), isA<AuthSuccess>()],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoadingState, AuthFailure] when Firebase sign-in fails',
      build: () {
        when(() => mockFirebaseRepo.signInWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer(
                (_) async => const ApiResult.failure('Wrong password'));
        return AuthCubit(firebaseAuthRepo: mockFirebaseRepo);
      },
      act: (cubit) => cubit.signInWithEmailAndPassword(
        email: 'firebase@example.com',
        password: 'wrongpass',
      ),
      expect: () => [isA<AuthLoadingState>(), isA<AuthFailure>()],
    );
  });

  group('AuthCubit – Google sign-in', () {
    blocTest<AuthCubit, AuthState>(
      'emits AuthInitial when user cancels Google sign-in (null credential)',
      build: () {
        when(() => mockFirebaseRepo.signInWithGoogle())
            .thenAnswer((_) async => const ApiResult.success(null));
        return AuthCubit(firebaseAuthRepo: mockFirebaseRepo);
      },
      act: (cubit) => cubit.signInWithGoogle(),
      expect: () => [isA<AuthGoogleLoading>(), isA<AuthInitial>()],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthGoogleLoading, AuthFailure] when Google sign-in fails',
      build: () {
        when(() => mockFirebaseRepo.signInWithGoogle()).thenAnswer(
            (_) async => const ApiResult.failure('Google sign-in failed'));
        return AuthCubit(firebaseAuthRepo: mockFirebaseRepo);
      },
      act: (cubit) => cubit.signInWithGoogle(),
      expect: () => [isA<AuthGoogleLoading>(), isA<AuthFailure>()],
    );
  });

  group('AuthCubit – reset', () {
    blocTest<AuthCubit, AuthState>(
      'reset emits AuthInitial regardless of current state',
      build: () => AuthCubit(firebaseAuthRepo: mockFirebaseRepo),
      seed: () => AuthFailure('some error'),
      act: (cubit) => cubit.reset(),
      expect: () => [isA<AuthInitial>()],
    );
  });

  group('AuthCubit – initial state', () {
    test('is AuthInitial', () {
      final cubit = AuthCubit(firebaseAuthRepo: mockFirebaseRepo);
      expect(cubit.state, isA<AuthInitial>());
      cubit.close();
    });
  });
}
