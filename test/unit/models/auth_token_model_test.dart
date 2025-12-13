import 'package:aurea_app/src/data/models/auth_token/auth_token.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthToken', () {
    test('should create an AuthToken from JSON with all fields', () {
      final json = {
        'accessToken': 'access_token_123',
        'refreshToken': 'refresh_token_456',
        'nameUser': 'John Doe',
        'email': 'john.doe@example.com',
        'phone': '1234567890',
        'isPremium': true,
      };

      final token = AuthToken.fromJson(json);

      expect(token.accessToken, 'access_token_123');
      expect(token.refreshToken, 'refresh_token_456');
      expect(token.nameUser, 'John Doe');
      expect(token.email, 'john.doe@example.com');
      expect(token.phone, '1234567890');
      expect(token.isPremium, true);
    });

    test('should create an AuthToken from JSON with null optional fields', () {
      final json = {
        'nameUser': 'Jane Smith',
        'email': 'jane.smith@example.com',
      };

      final token = AuthToken.fromJson(json);

      expect(token.accessToken, isNull);
      expect(token.refreshToken, isNull);
      expect(token.nameUser, 'Jane Smith');
      expect(token.email, 'jane.smith@example.com');
      expect(token.phone, '');
      expect(token.isPremium, false);
    });

    test('should create an AuthToken from empty JSON using defaults', () {
      final json = <String, dynamic>{};

      final token = AuthToken.fromJson(json);

      expect(token.accessToken, isNull);
      expect(token.refreshToken, isNull);
      expect(token.nameUser, '');
      expect(token.email, '');
      expect(token.phone, '');
      expect(token.isPremium, false);
    });

    test('should convert AuthToken to JSON', () {
      final token = AuthToken(
        accessToken: 'access_token_123',
        refreshToken: 'refresh_token_456',
        nameUser: 'John Doe',
        email: 'john.doe@example.com',
        phone: '1234567890',
        isPremium: true,
      );

      final json = token.toJson();

      expect(json['accessToken'], 'access_token_123');
      expect(json['refreshToken'], 'refresh_token_456');
      expect(json['nameUser'], 'John Doe');
      expect(json['email'], 'john.doe@example.com');
      expect(json['phone'], '1234567890');
      expect(json['isPremium'], true);
    });

    test('should convert AuthToken to JSON with null optional fields', () {
      final token = AuthToken(
        accessToken: null,
        refreshToken: null,
        nameUser: 'John Doe',
        email: 'john.doe@example.com',
        phone: '1234567890',
        isPremium: false,
      );

      final json = token.toJson();

      expect(json['accessToken'], isNull);
      expect(json['refreshToken'], isNull);
      expect(json['nameUser'], 'John Doe');
      expect(json['email'], 'john.doe@example.com');
      expect(json['phone'], '1234567890');
      expect(json['isPremium'], false);
    });

    test('should use default values when fields are missing', () {
      final json = {
        'accessToken': 'token123',
      };

      final token = AuthToken.fromJson(json);

      expect(token.accessToken, 'token123');
      expect(token.refreshToken, isNull);
      expect(token.nameUser, '');
      expect(token.email, '');
      expect(token.phone, '');
      expect(token.isPremium, false);
    });

    test('should handle empty string values', () {
      final json = {
        'accessToken': '',
        'refreshToken': '',
        'nameUser': '',
        'email': '',
        'phone': '',
        'isPremium': false,
      };

      final token = AuthToken.fromJson(json);

      expect(token.accessToken, '');
      expect(token.refreshToken, '');
      expect(token.nameUser, '');
      expect(token.email, '');
      expect(token.phone, '');
      expect(token.isPremium, false);
    });

    test('should create AuthToken using constructor with all fields', () {
      final token = AuthToken(
        accessToken: 'access_token_123',
        refreshToken: 'refresh_token_456',
        nameUser: 'John Doe',
        email: 'john.doe@example.com',
        phone: '1234567890',
        isPremium: true,
      );

      expect(token.accessToken, 'access_token_123');
      expect(token.refreshToken, 'refresh_token_456');
      expect(token.nameUser, 'John Doe');
      expect(token.email, 'john.doe@example.com');
      expect(token.phone, '1234567890');
      expect(token.isPremium, true);
    });

    test('should create AuthToken using constructor with defaults', () {
      const token = AuthToken();

      expect(token.accessToken, isNull);
      expect(token.refreshToken, isNull);
      expect(token.nameUser, '');
      expect(token.email, '');
      expect(token.phone, '');
      expect(token.isPremium, false);
    });

    test('should handle null accessToken and refreshToken in toJson', () {
      final token = AuthToken(
        accessToken: null,
        refreshToken: null,
        nameUser: 'Test User',
        email: 'test@example.com',
        phone: '1234567890',
        isPremium: false,
      );

      final json = token.toJson();

      expect(json['accessToken'], isNull);
      expect(json['refreshToken'], isNull);
      expect(json['nameUser'], 'Test User');
      expect(json['email'], 'test@example.com');
    });

    test('should handle isPremium as false by default', () {
      final json = {
        'accessToken': 'token123',
        'nameUser': 'User',
      };

      final token = AuthToken.fromJson(json);

      expect(token.isPremium, false);
    });

    test('should handle isPremium as true', () {
      final json = {
        'accessToken': 'token123',
        'nameUser': 'Premium User',
        'isPremium': true,
      };

      final token = AuthToken.fromJson(json);

      expect(token.isPremium, true);
    });
  });
}

