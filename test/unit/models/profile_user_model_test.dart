import 'package:aurea_app/src/data/models/profile_user/profile_user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProfileUserModel', () {
    test('should create ProfileUserModel from JSON', () {
      final json = {
        'nameUser': 'John Doe',
        'email': 'john@example.com',
        'phone': '123456789',
        'isPremium': true,
        'photo': 'https://example.com/photo.jpg',
      };

      final model = ProfileUserModel.fromJson(json);

      expect(model.nameUser, 'John Doe');
      expect(model.email, 'john@example.com');
      expect(model.phone, '123456789');
      expect(model.isPremium, true);
      expect(model.photo, 'https://example.com/photo.jpg');
    });

    test('should convert ProfileUserModel to JSON', () {
      final model = ProfileUserModel(
        nameUser: 'John Doe',
        email: 'john@example.com',
        phone: '123456789',
        isPremium: true,
        photo: 'https://example.com/photo.jpg',
      );

      final json = model.toJson();

      expect(json['nameUser'], 'John Doe');
      expect(json['email'], 'john@example.com');
      expect(json['phone'], '123456789');
      expect(json['isPremium'], true);
      expect(json['photo'], 'https://example.com/photo.jpg');
    });

    test('should handle null optional fields', () {
      final json = {
        'nameUser': 'John Doe',
        'phone': '123456789',
      };

      final model = ProfileUserModel.fromJson(json);

      expect(model.nameUser, 'John Doe');
      expect(model.phone, '123456789');
      expect(model.email, '');
      expect(model.isPremium, false);
      expect(model.photo, isNull);
    });

    test('should use default values when fields are missing', () {
      final json = <String, dynamic>{};

      final model = ProfileUserModel.fromJson(json);

      expect(model.nameUser, '');
      expect(model.email, '');
      expect(model.phone, '');
      expect(model.isPremium, false);
    });
  });
}

