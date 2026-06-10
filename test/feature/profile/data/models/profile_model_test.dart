import 'package:flutter_test/flutter_test.dart';
import 'package:bookia/feature/profile/data/model/profile_model.dart';

void main() {
  group('ProfileModel', () {
    final json = {
      'status': 200,
      'message': 'Profile loaded',
      'data': {
        'id': 1,
        'name': 'Alice Smith',
        'email': 'alice@example.com',
        'address': '123 Main St',
        'city': 'Cairo',
        'phone': '01234567890',
        'email_verified': true,
        'image': 'https://example.com/alice.jpg',
      },
    };

    test('fromJson parses top-level fields', () {
      final model = ProfileModel.fromJson(json);
      expect(model.status, 200);
      expect(model.message, 'Profile loaded');
      expect(model.data, isNotNull);
    });

    test('fromJson returns null data when absent', () {
      final model = ProfileModel.fromJson({'status': 401});
      expect(model.data, isNull);
    });
  });

  group('ProfileData.fromJson', () {
    final dataJson = {
      'id': 1,
      'name': 'Alice Smith',
      'email': 'alice@example.com',
      'address': '123 Main St',
      'city': 'Cairo',
      'phone': '01234567890',
      'email_verified': true,
      'image': 'https://example.com/alice.jpg',
    };

    test('maps all fields correctly', () {
      final data = ProfileData.fromJson(dataJson);
      expect(data.id, 1);
      expect(data.name, 'Alice Smith');
      expect(data.email, 'alice@example.com');
      expect(data.address, '123 Main St');
      expect(data.city, 'Cairo');
      expect(data.phone, '01234567890');
      expect(data.emailVerified, isTrue);
      expect(data.image, 'https://example.com/alice.jpg');
    });

    test('handles missing fields gracefully', () {
      final data = ProfileData.fromJson({'id': 5});
      expect(data.id, 5);
      expect(data.name, isNull);
      expect(data.email, isNull);
      expect(data.emailVerified, isNull);
    });
  });
}
