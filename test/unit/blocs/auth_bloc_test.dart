import 'package:aurea_app/src/data/models/auth_token/auth_token.dart';
import 'package:aurea_app/src/data/models/exceptions/exceptions.dart';
import 'package:aurea_app/src/data/models/profile_user/profile_user_model.dart';
import 'package:aurea_app/src/data/repository/auth_repository.dart';
import 'package:aurea_app/src/data/repository/firebase_auth_repository.dart';
import 'package:aurea_app/src/data/repository/profile_user_repository.dart';
import 'package:aurea_app/src/data/repository/token_repository.dart';
import 'package:aurea_app/src/logic/bloc/auth/auth_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_helpers.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockTokenRepository extends Mock implements TokenRepository {}

class MockFirebaseAuthRepository extends Mock implements FirebaseAuthRepository {}

class MockProfileUserRepository extends Mock implements ProfileUserRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(TestHelpers.createMockAuthToken());
    registerFallbackValue(TestHelpers.createMockProfileUser());
  });
  late AuthBloc authBloc;
  late MockAuthRepository mockAuthRepository;
  late MockTokenRepository mockTokenRepository;
  late MockFirebaseAuthRepository mockFirebaseAuthRepository;
  late MockProfileUserRepository mockProfileUserRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockTokenRepository = MockTokenRepository();
    mockFirebaseAuthRepository = MockFirebaseAuthRepository();
    mockProfileUserRepository = MockProfileUserRepository();

    authBloc = AuthBloc(
      authRepository: mockAuthRepository,
      tokenRepository: mockTokenRepository,
      firebaseAuthRepository: mockFirebaseAuthRepository,
      profileUserRepository: mockProfileUserRepository,
    );
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    group('AppStartRequest', () {
      blocTest<AuthBloc, AuthState>(
        'should emit Authenticated when there is a saved token',
        build: () {
          when(() => mockTokenRepository.getToken())
              .thenAnswer((_) async => 'valid_token');
          return authBloc;
        },
        act: (bloc) => bloc.add(const AppStartRequest()),
        expect: () => [const Authenticated()],
      );

      blocTest<AuthBloc, AuthState>(
        'should emit UnAuth when there is no saved token',
        build: () {
          when(() => mockTokenRepository.getToken())
              .thenAnswer((_) async => null);
          return authBloc;
        },
        act: (bloc) => bloc.add(const AppStartRequest()),
        expect: () => [const UnAuth()],
      );
    });

    group('SignInRequest', () {
      blocTest<AuthBloc, AuthState>(
        'should emit AuthLoading and then Authenticated when login is successful',
        build: () {
          final mockToken = TestHelpers.createMockAuthToken();
          when(() => mockAuthRepository.signIn(
                email: any(named: 'email'),
                password: any(named: 'password'),
              )).thenAnswer((_) async => mockToken);
          when(() => mockTokenRepository.saveToken(any()))
              .thenAnswer((_) async => {});
          when(() => mockProfileUserRepository.saveProfile(
                profile: any(named: 'profile'),
              )).thenAnswer((_) async => {});
          return authBloc;
        },
        act: (bloc) => bloc.add(const SignInRequest(
          username: 'test@example.com',
          password: 'password123',
        )),
        expect: () => [
          const AuthLoading(),
          const Authenticated(),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'should emit AuthLoading and then AuthError when login fails',
        build: () {
          when(() => mockAuthRepository.signIn(
                email: any(named: 'email'),
                password: any(named: 'password'),
              )).thenThrow(RepositoryException('Invalid credentials'));
          return authBloc;
        },
        act: (bloc) => bloc.add(const SignInRequest(
          username: 'test@example.com',
          password: 'wrong_password',
        )),
        expect: () => [
          const AuthLoading(),
          isA<AuthError>(),
        ],
      );
    });

    group('SignOutRequest', () {
      blocTest<AuthBloc, AuthState>(
        'should emit UnAuth after logout',
        build: () {
          when(() => mockFirebaseAuthRepository.signOut())
              .thenAnswer((_) async => {});
          when(() => mockTokenRepository.deleteAll())
              .thenAnswer((_) async => {});
          when(() => mockProfileUserRepository.deleteProfile())
              .thenAnswer((_) async => {});
          return authBloc;
        },
        act: (bloc) => bloc.add(const SignOutRequest()),
        expect: () => [const UnAuth()],
      );
    });
  });
}

