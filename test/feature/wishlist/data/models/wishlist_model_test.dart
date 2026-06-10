import 'package:flutter_test/flutter_test.dart';
import 'package:bookia/feature/wishlist/data/model/wishlist_model.dart';

void main() {
  group('WishlistModel', () {
    final json = {
      'status': 200,
      'message': 'Wishlist loaded',
      'data': {
        'current_page': 1,
        'total': 2,
        'data': [
          {
            'id': 10,
            'name': 'Clean Code',
            'price': '35.00',
            'category': 'Software',
            'image': 'https://example.com/clean.jpg',
            'discount': 0,
            'stock': 3,
            'description': 'Better code practices',
            'best_seller': 1,
          },
          {
            'id': 11,
            'name': 'The Pragmatic Programmer',
            'price': '40.00',
            'category': 'Software',
            'image': 'https://example.com/prag.jpg',
            'discount': 5,
            'stock': 7,
            'description': 'From journeyman to master',
            'best_seller': 0,
          },
        ],
      },
    };

    test('fromJson parses top-level fields', () {
      final model = WishlistModel.fromJson(json);
      expect(model.status, 200);
      expect(model.message, 'Wishlist loaded');
      expect(model.data, isNotNull);
    });

    test('fromJson parses wishlist data fields', () {
      final data = WishlistModel.fromJson(json).data!;
      expect(data.currentPage, 1);
      expect(data.total, 2);
      expect(data.items, hasLength(2));
    });

    test('fromJson returns null data when absent', () {
      final model = WishlistModel.fromJson({'status': 404});
      expect(model.data, isNull);
    });
  });

  group('WishlistItem.fromJson', () {
    final itemJson = {
      'id': 10,
      'name': 'Clean Code',
      'price': '35.00',
      'category': 'Software',
      'image': 'https://example.com/clean.jpg',
      'discount': 0,
      'stock': 3,
      'description': 'Better code practices',
      'best_seller': 1,
    };

    test('maps all fields correctly', () {
      final item = WishlistItem.fromJson(itemJson);
      expect(item.id, 10);
      expect(item.name, 'Clean Code');
      expect(item.price, '35.00');
      expect(item.category, 'Software');
      expect(item.image, 'https://example.com/clean.jpg');
      expect(item.discount, 0);
      expect(item.stock, 3);
      expect(item.description, 'Better code practices');
      expect(item.bestSeller, 1);
    });

    test('handles missing fields gracefully', () {
      final item = WishlistItem.fromJson({'id': 99});
      expect(item.id, 99);
      expect(item.name, isNull);
      expect(item.price, isNull);
    });
  });
}
