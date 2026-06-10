import 'package:flutter_test/flutter_test.dart';
import 'package:bookia/feature/auth/data/models/user_model.dart';

void main() {
  group('UserModel', () {
    final createdAt = DateTime(2024, 1, 15, 10, 30);
    final model = UserModel(
      uid: 'uid-123',
      name: 'John Doe',
      email: 'john@example.com',
      createdAt: createdAt,
    );

    final map = {
      'uid': 'uid-123',
      'name': 'John Doe',
      'email': 'john@example.com',
      'createdAt': createdAt.toIso8601String(),
    };

    test('fromMap produces correct fields', () {
      final result = UserModel.fromMap(map);
      expect(result.uid, 'uid-123');
      expect(result.name, 'John Doe');
      expect(result.email, 'john@example.com');
      expect(result.createdAt, createdAt);
    });

    test('toMap produces correct map', () {
      final result = model.toMap();
      expect(result['uid'], 'uid-123');
      expect(result['name'], 'John Doe');
      expect(result['email'], 'john@example.com');
      expect(result['createdAt'], createdAt.toIso8601String());
    });

    test('toMap and fromMap round-trip is stable', () {
      final roundTripped = UserModel.fromMap(model.toMap());
      expect(roundTripped.uid, model.uid);
      expect(roundTripped.name, model.name);
      expect(roundTripped.email, model.email);
      expect(roundTripped.createdAt, model.createdAt);
    });
  });
}
