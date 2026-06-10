import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/feature/home/cubit/home_cubit.dart';

class MockDio extends Mock implements Dio {}

// ---------------------------------------------------------------------------
// Fixture helpers
// ---------------------------------------------------------------------------

Response<dynamic> _sliderResponse() => Response(
      data: {
        'status': 200,
        'message': 'success',
        'data': {
          'sliders': [
            {'image': 'https://example.com/s1.jpg'},
            {'image': 'https://example.com/s2.jpg'},
          ],
        },
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );

Response<dynamic> _booksResponse() => Response(
      data: {
        'status': 200,
        'message': 'success',
        'data': {
          'products': [
            {
              'id': 1,
              'name': 'Flutter in Action',
              'description': 'A guide',
              'price': '29.99',
              'discount': 0,
              'price_after_discount': 29.99,
              'stock': 10,
              'best_seller': 1,
              'image': 'https://example.com/f.jpg',
              'category': 'Programming',
            },
          ],
        },
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );

Response<dynamic> _errorResponse() => Response(
      data: null,
      statusCode: 500,
      requestOptions: RequestOptions(path: ''),
    );

void main() {
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    DioFactory.dio = mockDio;
  });

  tearDown(() {
    DioFactory.dio = null;
  });

  group('HomeCubit – getHomeSliders', () {
    blocTest<HomeCubit, HomeState>(
      'emits [GetHomeSliderLoading, GetHomeSliderSuccess] on 200 response',
      build: () {
        when(() => mockDio.get(any())).thenAnswer((_) async => _sliderResponse());
        return HomeCubit();
      },
      act: (cubit) => cubit.getHomeSliders(),
      expect: () => [
        isA<GetHomeSliderLoading>(),
        isA<GetHomeSliderSuccess>(),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'GetHomeSliderSuccess carries the parsed sliders list',
      build: () {
        when(() => mockDio.get(any())).thenAnswer((_) async => _sliderResponse());
        return HomeCubit();
      },
      act: (cubit) => cubit.getHomeSliders(),
      expect: () => [
        isA<GetHomeSliderLoading>(),
        isA<GetHomeSliderSuccess>().having((s) => s.sliders, 'sliders', hasLength(2)),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [GetHomeSliderLoading, GetHomeSliderError] on non-200 response',
      build: () {
        when(() => mockDio.get(any())).thenAnswer((_) async => _errorResponse());
        return HomeCubit();
      },
      act: (cubit) => cubit.getHomeSliders(),
      expect: () => [
        isA<GetHomeSliderLoading>(),
        isA<GetHomeSliderError>(),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [GetHomeSliderLoading, GetHomeSliderError] when get throws',
      build: () {
        when(() => mockDio.get(any())).thenThrow(Exception('Network error'));
        return HomeCubit();
      },
      act: (cubit) => cubit.getHomeSliders(),
      expect: () => [
        isA<GetHomeSliderLoading>(),
        isA<GetHomeSliderError>(),
      ],
    );
  });

  group('HomeCubit – getBestSellerBooks', () {
    blocTest<HomeCubit, HomeState>(
      'emits [BestSellerLoading, BestSellerSuccess] on 200 response',
      build: () {
        when(() => mockDio.get(any())).thenAnswer((_) async => _booksResponse());
        return HomeCubit();
      },
      act: (cubit) => cubit.getBestSellerBooks(),
      expect: () => [
        isA<BestSellerLoading>(),
        isA<BestSellerSuccess>(),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'BestSellerSuccess carries the parsed books list',
      build: () {
        when(() => mockDio.get(any())).thenAnswer((_) async => _booksResponse());
        return HomeCubit();
      },
      act: (cubit) => cubit.getBestSellerBooks(),
      expect: () => [
        isA<BestSellerLoading>(),
        isA<BestSellerSuccess>().having((s) => s.books, 'books', hasLength(1)),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [BestSellerLoading, BestSellerError] on non-200 response',
      build: () {
        when(() => mockDio.get(any())).thenAnswer((_) async => _errorResponse());
        return HomeCubit();
      },
      act: (cubit) => cubit.getBestSellerBooks(),
      expect: () => [
        isA<BestSellerLoading>(),
        isA<BestSellerError>(),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [BestSellerLoading, BestSellerError] when get throws',
      build: () {
        when(() => mockDio.get(any())).thenThrow(Exception('Timeout'));
        return HomeCubit();
      },
      act: (cubit) => cubit.getBestSellerBooks(),
      expect: () => [
        isA<BestSellerLoading>(),
        isA<BestSellerError>(),
      ],
    );
  });

  group('HomeCubit – initial state', () {
    test('is HomeInitial', () {
      when(() => mockDio.get(any())).thenAnswer((_) async => _sliderResponse());
      final cubit = HomeCubit();
      expect(cubit.state, isA<HomeInitial>());
      cubit.close();
    });
  });
}
