import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/feature/cart/cubit/cart_cubit.dart';

class MockDio extends Mock implements Dio {}

// ---------------------------------------------------------------------------
// Fixtures
// ---------------------------------------------------------------------------

final _cartData = {
  'id': 7,
  'user': {'user_id': 1, 'user_name': 'Test User'},
  'total': '26.99',
  'cart_items': [
    {
      'item_id': 101,
      'item_product_id': 1,
      'item_product_name': 'Flutter Book',
      'item_product_image': 'https://example.com/f.jpg',
      'item_product_price': '29.99',
      'item_product_discount': 10,
      'item_product_price_after_discount': 26.99,
      'item_product_stock': 5,
      'item_quantity': 1,
      'item_total': 26.99,
    },
  ],
};

Response<dynamic> _getCartOk() => Response(
      data: {'status': 200, 'message': 'ok', 'data': _cartData},
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );

Response<dynamic> _getCartEmpty() => Response(
      data: {
        'status': 200,
        'message': 'ok',
        'data': {
          'id': 8,
          'user': null,
          'total': '0.00',
          'cart_items': [],
        },
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );

Response<dynamic> _addToCartOk() => Response(
      data: {'status': 201, 'message': 'Added successfully', 'data': _cartData},
      statusCode: 201,
      requestOptions: RequestOptions(path: ''),
    );

Response<dynamic> _removeOk() => Response(
      data: {'status': 200, 'message': 'Removed'},
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

  group('CartCubit – getCart', () {
    blocTest<CartCubit, CartState>(
      'emits [GetCartLoading, GetCartSuccess] on 200 response',
      build: () {
        when(() => mockDio.get(any())).thenAnswer((_) async => _getCartOk());
        return CartCubit();
      },
      act: (cubit) => cubit.getCart(),
      expect: () => [isA<GetCartLoading>(), isA<GetCartSuccess>()],
    );

    blocTest<CartCubit, CartState>(
      'GetCartSuccess carries the parsed cart data',
      build: () {
        when(() => mockDio.get(any())).thenAnswer((_) async => _getCartOk());
        return CartCubit();
      },
      act: (cubit) => cubit.getCart(),
      expect: () => [
        isA<GetCartLoading>(),
        isA<GetCartSuccess>().having(
          (s) => s.cart.cartItems,
          'cartItems',
          hasLength(1),
        ),
      ],
    );

    blocTest<CartCubit, CartState>(
      'emits GetCartSuccess with empty items list when cart is empty',
      build: () {
        when(() => mockDio.get(any())).thenAnswer((_) async => _getCartEmpty());
        return CartCubit();
      },
      act: (cubit) => cubit.getCart(),
      expect: () => [
        isA<GetCartLoading>(),
        isA<GetCartSuccess>().having(
          (s) => s.cart.cartItems,
          'cartItems',
          isEmpty,
        ),
      ],
    );

    blocTest<CartCubit, CartState>(
      'emits [GetCartLoading, GetCartError] on non-200 response',
      build: () {
        when(() => mockDio.get(any())).thenAnswer((_) async => _error());
        return CartCubit();
      },
      act: (cubit) => cubit.getCart(),
      expect: () => [isA<GetCartLoading>(), isA<GetCartError>()],
    );

    blocTest<CartCubit, CartState>(
      'emits [GetCartLoading, GetCartError] when get throws',
      build: () {
        when(() => mockDio.get(any())).thenThrow(Exception('Network error'));
        return CartCubit();
      },
      act: (cubit) => cubit.getCart(),
      expect: () => [isA<GetCartLoading>(), isA<GetCartError>()],
    );
  });

  group('CartCubit – addToCart', () {
    blocTest<CartCubit, CartState>(
      'emits [AddToCartLoading, AddToCartSuccess, GetCartLoading, GetCartSuccess] on success',
      build: () {
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => _addToCartOk());
        when(() => mockDio.get(any())).thenAnswer((_) async => _getCartOk());
        return CartCubit();
      },
      act: (cubit) => cubit.addToCart(1),
      expect: () => [
        isA<AddToCartLoading>(),
        isA<AddToCartSuccess>(),
        isA<GetCartLoading>(),
        isA<GetCartSuccess>(),
      ],
    );

    blocTest<CartCubit, CartState>(
      'emits [AddToCartLoading, AddToCartError] on failure response',
      build: () {
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => _error());
        return CartCubit();
      },
      act: (cubit) => cubit.addToCart(99),
      expect: () => [isA<AddToCartLoading>(), isA<AddToCartError>()],
    );

    blocTest<CartCubit, CartState>(
      'emits [AddToCartLoading, AddToCartError] when post throws',
      build: () {
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenThrow(Exception('Timeout'));
        return CartCubit();
      },
      act: (cubit) => cubit.addToCart(5),
      expect: () => [isA<AddToCartLoading>(), isA<AddToCartError>()],
    );
  });

  group('CartCubit – removeFromCart', () {
    blocTest<CartCubit, CartState>(
      'emits [RemoveFromCartLoading, RemoveFromCartSuccess, GetCartLoading, GetCartSuccess] on success',
      build: () {
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => _removeOk());
        when(() => mockDio.get(any())).thenAnswer((_) async => _getCartOk());
        return CartCubit();
      },
      act: (cubit) => cubit.removeFromCart(101),
      expect: () => [
        isA<RemoveFromCartLoading>(),
        isA<RemoveFromCartSuccess>(),
        isA<GetCartLoading>(),
        isA<GetCartSuccess>(),
      ],
    );

    blocTest<CartCubit, CartState>(
      'emits [RemoveFromCartLoading, RemoveFromCartError] on failure',
      build: () {
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => _error());
        return CartCubit();
      },
      act: (cubit) => cubit.removeFromCart(101),
      expect: () => [isA<RemoveFromCartLoading>(), isA<RemoveFromCartError>()],
    );
  });

  group('CartCubit – updateCartItem', () {
    blocTest<CartCubit, CartState>(
      'emits GetCartSuccess after successful update via silent refresh',
      build: () {
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => _removeOk()); // 200 = success
        when(() => mockDio.get(any())).thenAnswer((_) async => _getCartOk());
        return CartCubit();
      },
      act: (cubit) => cubit.updateCartItem(itemId: 101, quantity: 3),
      expect: () => [isA<GetCartSuccess>()],
    );

    blocTest<CartCubit, CartState>(
      'emits UpdateCartError when update fails',
      build: () {
        when(() => mockDio.post(any(), data: any(named: 'data')))
            .thenAnswer((_) async => _error());
        return CartCubit();
      },
      act: (cubit) => cubit.updateCartItem(itemId: 101, quantity: 2),
      expect: () => [isA<UpdateCartError>()],
    );
  });

  group('CartCubit – initial state', () {
    test('is CartInitial', () {
      final cubit = CartCubit();
      expect(cubit.state, isA<CartInitial>());
      cubit.close();
    });
  });
}
