import 'package:flutter_test/flutter_test.dart';
import 'package:bookia/feature/home/data/models/books_model.dart';

void main() {
  group('BooksModel', () {
    final json = {
      'status': 200,
      'message': 'success',
      'data': {
        'products': [
          {
            'id': 1,
            'name': 'Flutter in Action',
            'description': 'A comprehensive guide to Flutter',
            'price': '29.99',
            'discount': 10,
            'price_after_discount': 26.99,
            'stock': 5,
            'best_seller': 1,
            'image': 'https://example.com/flutter.jpg',
            'category': 'Programming',
          },
        ],
      },
    };

    test('fromJson parses top-level fields', () {
      final model = BooksModel.fromJson(json);
      expect(model.status, 200);
      expect(model.message, 'success');
      expect(model.data, isNotNull);
    });

    test('fromJson parses nested products list', () {
      final model = BooksModel.fromJson(json);
      expect(model.data!.products, hasLength(1));
    });

    test('fromJson returns null data when data key is absent', () {
      final model = BooksModel.fromJson({'status': 404});
      expect(model.data, isNull);
    });
  });

  group('Products.fromJson', () {
    final productJson = {
      'id': 42,
      'name': 'Dart Cookbook',
      'description': 'Recipes for Dart developers',
      'price': '19.99',
      'discount': 5,
      'price_after_discount': 18.99,
      'stock': 10,
      'best_seller': 0,
      'image': 'https://example.com/dart.jpg',
      'category': 'Programming',
    };

    test('fromJson maps all fields correctly', () {
      final p = Products.fromJson(productJson);
      expect(p.id, 42);
      expect(p.name, 'Dart Cookbook');
      expect(p.description, 'Recipes for Dart developers');
      expect(p.price, '19.99');
      expect(p.discount, 5);
      expect(p.priceAfterDiscount, closeTo(18.99, 0.01));
      expect(p.stock, 10);
      expect(p.bestSeller, 0);
      expect(p.image, 'https://example.com/dart.jpg');
      expect(p.category, 'Programming');
    });

    test('fromJson handles null price_after_discount', () {
      final p = Products.fromJson({'id': 1, 'name': 'Test'});
      expect(p.priceAfterDiscount, isNull);
    });
  });
}
