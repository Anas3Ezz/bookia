import 'package:flutter_test/flutter_test.dart';
import 'package:bookia/feature/cart/data/model/add_to_cart_model.dart';

void main() {
  group('CartModel', () {
    final cartJson = {
      'status': 200,
      'message': 'Cart loaded',
      'data': {
        'id': 7,
        'user': {'user_id': 1, 'user_name': 'Jane'},
        'total': '53.98',
        'cart_items': [
          {
            'item_id': 101,
            'item_product_id': 1,
            'item_product_name': 'Flutter Book',
            'item_product_image': 'https://example.com/flutter.jpg',
            'item_product_price': '29.99',
            'item_product_discount': 10,
            'item_product_price_after_discount': 26.99,
            'item_product_stock': 5,
            'item_quantity': 2,
            'item_total': 53.98,
          },
        ],
      },
    };

    test('fromJson parses top-level fields', () {
      final model = CartModel.fromJson(cartJson);
      expect(model.status, 200);
      expect(model.message, 'Cart loaded');
      expect(model.data, isNotNull);
    });

    test('fromJson parses cart data', () {
      final data = CartModel.fromJson(cartJson).data!;
      expect(data.id, 7);
      expect(data.total, '53.98');
      expect(data.cartItems, hasLength(1));
    });

    test('fromJson parses user inside cart data', () {
      final user = CartModel.fromJson(cartJson).data!.user!;
      expect(user.userId, 1);
      expect(user.userName, 'Jane');
    });

    test('fromJson returns null data when data key is absent', () {
      final model = CartModel.fromJson({'status': 401});
      expect(model.data, isNull);
    });
  });

  group('CartItem.fromJson', () {
    final itemJson = {
      'item_id': 101,
      'item_product_id': 5,
      'item_product_name': 'Dart Book',
      'item_product_image': 'https://example.com/dart.jpg',
      'item_product_price': '19.99',
      'item_product_discount': 0,
      'item_product_price_after_discount': 19.99,
      'item_product_stock': 8,
      'item_quantity': 3,
      'item_total': 59.97,
    };

    test('maps all fields correctly', () {
      final item = CartItem.fromJson(itemJson);
      expect(item.itemId, 101);
      expect(item.itemProductId, 5);
      expect(item.itemProductName, 'Dart Book');
      expect(item.itemProductImage, 'https://example.com/dart.jpg');
      expect(item.itemProductPrice, '19.99');
      expect(item.itemProductDiscount, 0);
      expect(item.itemProductPriceAfterDiscount, closeTo(19.99, 0.01));
      expect(item.itemProductStock, 8);
      expect(item.itemQuantity, 3);
      expect(item.itemTotal, closeTo(59.97, 0.01));
    });

    test('handles null numeric fields gracefully', () {
      final item = CartItem.fromJson({'item_id': 200});
      expect(item.itemProductPriceAfterDiscount, isNull);
      expect(item.itemTotal, isNull);
    });
  });
}
