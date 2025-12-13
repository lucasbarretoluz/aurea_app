import 'package:aurea_app/src/data/models/auth_token/auth_token.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthToken Edge Cases', () {
    test('should handle very long accessToken', () {
      final longToken = 'A' * 1000;
      final json = {
        'accessToken': longToken,
        'nameUser': 'User',
      };

      final token = AuthToken.fromJson(json);

      expect(token.accessToken, longToken);
      expect(token.accessToken!.length, 1000);
    });

    test('should handle very long refreshToken', () {
      final longToken = 'B' * 2000;
      final json = {
        'refreshToken': longToken,
        'nameUser': 'User',
      };

      final token = AuthToken.fromJson(json);

      expect(token.refreshToken, longToken);
      expect(token.refreshToken!.length, 2000);
    });

    test('should handle very long nameUser', () {
      final longName = 'C' * 500;
      final json = {
        'nameUser': longName,
        'email': 'test@example.com',
      };

      final token = AuthToken.fromJson(json);

      expect(token.nameUser, longName);
      expect(token.nameUser.length, 500);
    });

    test('should handle very long email', () {
      final longEmail = 'a' * 200 + '@example.com';
      final json = {
        'email': longEmail,
        'nameUser': 'User',
      };

      final token = AuthToken.fromJson(json);

      expect(token.email, longEmail);
      expect(token.email.length, greaterThan(200));
    });

    test('should handle very long phone', () {
      final longPhone = '1' * 50;
      final json = {
        'phone': longPhone,
        'nameUser': 'User',
      };

      final token = AuthToken.fromJson(json);

      expect(token.phone, longPhone);
      expect(token.phone.length, 50);
    });

    test('should handle special characters in nameUser', () {
      final specialName = 'João da Silva & Cia. - 123';
      final json = {
        'nameUser': specialName,
        'email': 'test@example.com',
      };

      final token = AuthToken.fromJson(json);

      expect(token.nameUser, specialName);
    });

    test('should handle special characters in email', () {
      final specialEmail = 'user+test@example-domain.co.uk';
      final json = {
        'email': specialEmail,
        'nameUser': 'User',
      };

      final token = AuthToken.fromJson(json);

      expect(token.email, specialEmail);
    });

    test('should handle special characters in phone', () {
      final specialPhone = '+55 (11) 98765-4321';
      final json = {
        'phone': specialPhone,
        'nameUser': 'User',
      };

      final token = AuthToken.fromJson(json);

      expect(token.phone, specialPhone);
    });

    test('should handle JSON with only accessToken', () {
      final json = {
        'accessToken': 'token_only',
      };

      final token = AuthToken.fromJson(json);

      expect(token.accessToken, 'token_only');
      expect(token.refreshToken, isNull);
      expect(token.nameUser, '');
      expect(token.email, '');
      expect(token.phone, '');
      expect(token.isPremium, false);
    });

    test('should handle JSON with only refreshToken', () {
      final json = {
        'refreshToken': 'refresh_only',
      };

      final token = AuthToken.fromJson(json);

      expect(token.accessToken, isNull);
      expect(token.refreshToken, 'refresh_only');
      expect(token.nameUser, '');
      expect(token.email, '');
      expect(token.phone, '');
      expect(token.isPremium, false);
    });

    test('should handle JSON with only isPremium', () {
      final json = {
        'isPremium': true,
      };

      final token = AuthToken.fromJson(json);

      expect(token.accessToken, isNull);
      expect(token.refreshToken, isNull);
      expect(token.nameUser, '');
      expect(token.email, '');
      expect(token.phone, '');
      expect(token.isPremium, true);
    });

    test('should handle round-trip JSON conversion', () {
      final originalToken = AuthToken(
        accessToken: 'access_token_123',
        refreshToken: 'refresh_token_456',
        nameUser: 'John Doe',
        email: 'john.doe@example.com',
        phone: '1234567890',
        isPremium: true,
      );

      final json = originalToken.toJson();
      final convertedToken = AuthToken.fromJson(json);

      expect(convertedToken.accessToken, originalToken.accessToken);
      expect(convertedToken.refreshToken, originalToken.refreshToken);
      expect(convertedToken.nameUser, originalToken.nameUser);
      expect(convertedToken.email, originalToken.email);
      expect(convertedToken.phone, originalToken.phone);
      expect(convertedToken.isPremium, originalToken.isPremium);
    });

    test('should handle round-trip JSON conversion with nulls', () {
      final originalToken = AuthToken(
        accessToken: null,
        refreshToken: null,
        nameUser: 'User',
        email: 'user@example.com',
        phone: '123',
        isPremium: false,
      );

      final json = originalToken.toJson();
      final convertedToken = AuthToken.fromJson(json);

      expect(convertedToken.accessToken, originalToken.accessToken);
      expect(convertedToken.refreshToken, originalToken.refreshToken);
      expect(convertedToken.nameUser, originalToken.nameUser);
      expect(convertedToken.email, originalToken.email);
      expect(convertedToken.phone, originalToken.phone);
      expect(convertedToken.isPremium, originalToken.isPremium);
    });

    test('should handle Unicode characters in nameUser', () {
      final unicodeName = 'José María Ñoño 中文';
      final json = {
        'nameUser': unicodeName,
        'email': 'test@example.com',
      };

      final token = AuthToken.fromJson(json);

      expect(token.nameUser, unicodeName);
    });

    test('should handle Unicode characters in email', () {
      final unicodeEmail = 'testé@exämple.com';
      final json = {
        'email': unicodeEmail,
        'nameUser': 'User',
      };

      final token = AuthToken.fromJson(json);

      expect(token.email, unicodeEmail);
    });
  });
}

