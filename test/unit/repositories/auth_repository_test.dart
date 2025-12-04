import 'package:aurea_app/src/data/models/auth_token/auth_token.dart';
import 'package:aurea_app/src/data/models/exceptions/exceptions.dart';
import 'package:aurea_app/src/data/repository/auth_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_helpers.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.env.dev');
  });

  group('AuthRepository', () {
    late AuthRepository authRepository;

    setUp(() {
      authRepository = AuthRepository();
    });

    group('signIn', () {
      test('should be an async method that returns Future<AuthToken>', () {
        expect(
          authRepository.signIn(
            email: 'test@example.com',
            password: 'password123',
          ),
          isA<Future<AuthToken>>(),
        );
      });
    });

    group('singUp', () {
      test('should be an async method that returns Future<AuthToken>', () {
        expect(
          authRepository.singUp(
            name: 'New User',
            email: 'newuser@example.com',
            password: 'password123',
          ),
          isA<Future<AuthToken>>(),
        );
      });
    });
  });
}

