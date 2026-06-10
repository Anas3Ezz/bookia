import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/feature/search/cubit/search_cubit.dart';

class MockDio extends Mock implements Dio {}

// ---------------------------------------------------------------------------
// Fixtures
// ---------------------------------------------------------------------------

Response<dynamic> _booksResponse() => Response(
      data: {
        'status': 200,
        'message': 'ok',
        'data': {
          'products': [
            {
              'id': 1,
              'name': 'Flutter in Action',
              'description': 'A guide',
              'price': '29.99',
              'discount': 0,
              'price_after_discount': 29.99,
              'stock': 5,
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

Response<dynamic> _emptyResponse() => Response(
      data: {
        'status': 200,
        'message': 'ok',
        'data': {'products': []},
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

  group('SearchCubit – onSearchChanged with empty query', () {
    blocTest<SearchCubit, SearchState>(
      'emits SearchInitial immediately when query is blank',
      build: () => SearchCubit(),
      act: (cubit) => cubit.onSearchChanged(''),
      expect: () => [isA<SearchInitial>()],
    );

    blocTest<SearchCubit, SearchState>(
      'emits SearchInitial immediately when query is only whitespace',
      build: () => SearchCubit(),
      act: (cubit) => cubit.onSearchChanged('   '),
      expect: () => [isA<SearchInitial>()],
    );
  });

  group('SearchCubit – onSearchChanged after debounce (600ms wait)', () {
    blocTest<SearchCubit, SearchState>(
      'emits [SearchLoading, SearchSuccess] when results are found',
      build: () {
        when(() => mockDio.get(
              any(),
              queryParameters: any(named: 'queryParameters'),
            )).thenAnswer((_) async => _booksResponse());
        return SearchCubit();
      },
      act: (cubit) => cubit.onSearchChanged('flutter'),
      wait: const Duration(milliseconds: 600),
      expect: () => [isA<SearchLoading>(), isA<SearchSuccess>()],
    );

    blocTest<SearchCubit, SearchState>(
      'SearchSuccess carries the parsed books',
      build: () {
        when(() => mockDio.get(
              any(),
              queryParameters: any(named: 'queryParameters'),
            )).thenAnswer((_) async => _booksResponse());
        return SearchCubit();
      },
      act: (cubit) => cubit.onSearchChanged('flutter'),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        isA<SearchLoading>(),
        isA<SearchSuccess>().having((s) => s.books, 'books', hasLength(1)),
      ],
    );

    blocTest<SearchCubit, SearchState>(
      'emits [SearchLoading, SearchEmpty] when no products match',
      build: () {
        when(() => mockDio.get(
              any(),
              queryParameters: any(named: 'queryParameters'),
            )).thenAnswer((_) async => _emptyResponse());
        return SearchCubit();
      },
      act: (cubit) => cubit.onSearchChanged('xyznotfound'),
      wait: const Duration(milliseconds: 600),
      expect: () => [isA<SearchLoading>(), isA<SearchEmpty>()],
    );

    blocTest<SearchCubit, SearchState>(
      'emits [SearchLoading, SearchError] on non-200 response',
      build: () {
        when(() => mockDio.get(
              any(),
              queryParameters: any(named: 'queryParameters'),
            )).thenAnswer((_) async => _errorResponse());
        return SearchCubit();
      },
      act: (cubit) => cubit.onSearchChanged('flutter'),
      wait: const Duration(milliseconds: 600),
      expect: () => [isA<SearchLoading>(), isA<SearchError>()],
    );

    blocTest<SearchCubit, SearchState>(
      'emits [SearchLoading, SearchError] when get throws',
      build: () {
        when(() => mockDio.get(
              any(),
              queryParameters: any(named: 'queryParameters'),
            )).thenThrow(Exception('Network failure'));
        return SearchCubit();
      },
      act: (cubit) => cubit.onSearchChanged('dart'),
      wait: const Duration(milliseconds: 600),
      expect: () => [isA<SearchLoading>(), isA<SearchError>()],
    );
  });

  group('SearchCubit – debounce cancellation', () {
    blocTest<SearchCubit, SearchState>(
      'only executes the last query when onSearchChanged is called rapidly',
      build: () {
        when(() => mockDio.get(
              any(),
              queryParameters: any(named: 'queryParameters'),
            )).thenAnswer((_) async => _booksResponse());
        return SearchCubit();
      },
      act: (cubit) async {
        cubit.onSearchChanged('f');
        cubit.onSearchChanged('fl');
        cubit.onSearchChanged('flu');
        cubit.onSearchChanged('flutter');
      },
      wait: const Duration(milliseconds: 600),
      // Only one SearchLoading + SearchSuccess pair from the final query
      expect: () => [isA<SearchLoading>(), isA<SearchSuccess>()],
    );
  });

  group('SearchCubit – initial state', () {
    test('is SearchInitial', () {
      final cubit = SearchCubit();
      expect(cubit.state, isA<SearchInitial>());
      cubit.close();
    });
  });
}
