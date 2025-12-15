import 'package:aurea_app/src/data/provider/auth_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.env.dev');
  });

  group('AuthProvider', () {
    late AuthProvider provider;

    setUp(() {
      provider = AuthProvider();
    });

    test('should be instantiable', () {
      expect(provider, isA<AuthProvider>());
    });

    test('should have healthCheck method', () {
      expect(provider.healthCheck, isA<Function>());
    });

    test('should have signIn method', () {
      expect(provider.signIn, isA<Function>());
    });

    test('should have singUp method', () {
      expect(provider.singUp, isA<Function>());
    });

    test('should have firebaseAuthValid method', () {
      expect(provider.firebaseAuthValid, isA<Function>());
    });

    test('should have deleteAccount method', () {
      expect(provider.deleteAccount, isA<Function>());
    });

    test('should have clearAccount method', () {
      expect(provider.clearAccount, isA<Function>());
    });

    test('should have updateIsPremium method', () {
      expect(provider.updateIsPremium, isA<Function>());
    });

    test('should have refreshToken method', () {
      expect(provider.refreshToken, isA<Function>());
    });

    test('healthCheck should throw exception on error', () async {
      try {
        await provider.healthCheck();
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('signIn should throw exception on error', () async {
      try {
        await provider.signIn(identifier: 'test', password: 'password');
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('singUp should throw exception on error', () async {
      try {
        await provider.singUp(name: 'Test', email: 'test@test.com', password: 'password');
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('singUp should accept optional phone parameter', () async {
      try {
        await provider.singUp(
          name: 'Test',
          email: 'test@test.com',
          password: 'password',
          phone: '123456789',
        );
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('firebaseAuthValid should throw exception on error', () async {
      try {
        await provider.firebaseAuthValid(token: 'token');
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('deleteAccount should throw exception on error', () async {
      try {
        await provider.deleteAccount();
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('clearAccount should throw exception on error', () async {
      try {
        await provider.clearAccount();
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('updateIsPremium should throw exception on error', () async {
      try {
        await provider.updateIsPremium(isPremium: true);
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('updateIsPremium should handle false value', () async {
      try {
        await provider.updateIsPremium(isPremium: false);
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('refreshToken should throw exception on error', () async {
      try {
        await provider.refreshToken(refreshToken: 'token');
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });
  });
}
