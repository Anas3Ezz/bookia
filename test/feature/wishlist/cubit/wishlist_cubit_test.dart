import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/feature/wishlist/cubit/wishlist_cubit.dart';

class MockDio extends Mock implements Dio {}

// ---------------------------------------------------------------------------
// Fixtures
// ---------------------------------------------------------------------------

final _wishlistItems = [
  {
    'id': 10,
    'name': 'Clean Code',
    'price': '35.00',
    'category': 'Software',
    'image': 'https://example.com/cc.jpg',
    'discount': 0,
    'stock': 3,
    'description': 'Better code',
    'best_seller': 1,
  },
];

Response<dynamic> _wishlistOk() => Response(
      data: {
        'status': 200,
        'message': 'ok',
        'data': {
          'current_page': 1,
          'total': 1,
          'data': _wishlistItems,
        },
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );

Response<dynamic> _wishlistEmpty() => Response(
      data: {
        'status': 200,
        'message': 'ok',
        'data': {'current_page': 1, 'total': 0, 'data': []},
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );

Response<dynamic> _ok200() => Response(
      data: {'status': 200, 'message': 'ok'},
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

  setUp(() {
    mockDio = MockDio();
    DioFactory.dio = mockDio;
  });

  tearDown(() {
    DioFactory.dio = null;
  });

  group('WishlistCubit – getWishlist', () {
    blocTest<WishlistCubit, WishlistState>(
      'emits [GetWishlistLoading, GetWishlistSuccess] on 200 response',
      build: () {
        when(() => mockDio.get(any())).thenAnswer((_) async => _wishlistOk());
        return WishlistCubit();
      },
      act: (cubit) => cubit.getWishlist(),
      expect: () => [isA<GetWishlistLoading>(), isA<GetWishlistSuccess>()],
    );

    blocTest<WishlistCubit, WishlistState>(
      'GetWishlistSuccess carries the parsed items',
      build: () {
        when(() => mockDio.get(any())).thenAnswer((_) async => _wishlistOk());
        return WishlistCubit();
      },
      act: (cubit) => cubit.getWishlist(),
      expect: () => [
        isA<GetWishlistLoading>(),
        isA<GetWishlistSuccess>().having((s) => s.items, 'items', hasLength(1)),
      ],
    );

    blocTest<WishlistCubit, WishlistState>(
      'emits GetWishlistSuccess with empty list when wishlist is empty',
      build: () {
        when(() => mockDio.get(any())).thenAnswer((_) async => _wishlistEmpty());
        return WishlistCubit();
      },
      act: (cubit) => cubit.getWishlist(),
      expect: () => [
        isA<GetWishlistLoading>(),
        isA<GetWishlistSuccess>().having((s) => s.items, 'items', isEmpty),
      ],
    );

    blocTest<WishlistCubit, WishlistState>(
      'emits [GetWishlistLoading, GetWishlistError] on non-200 response',
      build: () {
        when(() => mockDio.get(any())).thenAnswer((_) async => _error());
        return WishlistCubit();
      },
      act: (cubit) => cubit.getWishlist(),
      expect: () => [isA<GetWishlistLoading>(), isA<GetWishlistError>()],
    );

    blocTest<WishlistCubit, WishlistState>(
      'emits [GetWishlistLoading, GetWishlistError] when get throws',
      build: () {
        when(() => mockDio.get(any())).thenThrow(Exception('Connection failed'));
        return WishlistCubit();
      },
      act: (cubit) => cubit.getWishlist(),
      expect: () => [isA<GetWishlistLoading>(), isA<GetWishlistError>()],
    );
  });

  group('WishlistCubit – addToWishlist', () {
    blocTest<WishlistCubit, WishlistState>(
      'emits [AddToWishlistLoading, AddToWishlistSuccess, GetWishlistSuccess] on success',
      build: () {
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => _ok200());
        when(() => mockDio.get(any())).thenAnswer((_) async => _wishlistOk());
        return WishlistCubit();
      },
      act: (cubit) => cubit.addToWishlist(10),
      expect: () => [
        isA<AddToWishlistLoading>(),
        isA<AddToWishlistSuccess>(),
        isA<GetWishlistSuccess>(),
      ],
    );

    blocTest<WishlistCubit, WishlistState>(
      'emits [AddToWishlistLoading, AddToWishlistError] on failure',
      build: () {
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => _error());
        return WishlistCubit();
      },
      act: (cubit) => cubit.addToWishlist(99),
      expect: () => [isA<AddToWishlistLoading>(), isA<AddToWishlistError>()],
    );
  });

  group('WishlistCubit – removeFromWishlist', () {
    blocTest<WishlistCubit, WishlistState>(
      'emits [RemoveFromWishlistLoading, RemoveFromWishlistSuccess, GetWishlistSuccess] on success',
      build: () {
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => _ok200());
        when(() => mockDio.get(any())).thenAnswer((_) async => _wishlistOk());
        return WishlistCubit();
      },
      act: (cubit) => cubit.removeFromWishlist(10),
      expect: () => [
        isA<RemoveFromWishlistLoading>(),
        isA<RemoveFromWishlistSuccess>(),
        isA<GetWishlistSuccess>(),
      ],
    );

    blocTest<WishlistCubit, WishlistState>(
      'emits [RemoveFromWishlistLoading, RemoveFromWishlistError] on failure',
      build: () {
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => _error());
        return WishlistCubit();
      },
      act: (cubit) => cubit.removeFromWishlist(10),
      expect: () => [isA<RemoveFromWishlistLoading>(), isA<RemoveFromWishlistError>()],
    );
  });

  group('WishlistCubit – isInWishlist', () {
    test('returns false initially for any id', () {
      final cubit = WishlistCubit();
      expect(cubit.isInWishlist(10), isFalse);
      cubit.close();
    });

    blocTest<WishlistCubit, WishlistState>(
      'returns true for an id after addToWishlist succeeds',
      build: () {
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => _ok200());
        when(() => mockDio.get(any())).thenAnswer((_) async => _wishlistOk());
        return WishlistCubit();
      },
      act: (cubit) => cubit.addToWishlist(10),
      verify: (cubit) => expect(cubit.isInWishlist(10), isTrue),
    );
  });

  group('WishlistCubit – initial state', () {
    test('is WishlistInitial', () {
      final cubit = WishlistCubit();
      expect(cubit.state, isA<WishlistInitial>());
      cubit.close();
    });
  });
}
