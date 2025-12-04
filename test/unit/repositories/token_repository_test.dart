import 'package:aurea_app/src/data/repository/token_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TokenRepository', () {
    test('should be a class that can be instantiated', () {
      final tokenRepository = TokenRepository();
      expect(tokenRepository, isA<TokenRepository>());
    });

    test('should have saveToken method that accepts AuthToken', () {
      final tokenRepository = TokenRepository();
      expect(tokenRepository.saveToken, isA<Function>());
    });

    test('should have getToken method', () {
      final tokenRepository = TokenRepository();
      expect(tokenRepository.getToken, isA<Function>());
    });

    test('should have deleteToken method', () {
      final tokenRepository = TokenRepository();
      expect(tokenRepository.deleteToken, isA<Function>());
    });

    test('should have deleteAll method', () {
      final tokenRepository = TokenRepository();
      expect(tokenRepository.deleteAll, isA<Function>());
    });
  });
}

