import 'package:aurea_app/src/data/repository/token_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/auth_token/auth_token.dart';
import '../../../data/models/exceptions/exceptions.dart';
import '../../../data/models/profile_user/profile_user_model.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../data/repository/firebase_auth_repository.dart';
import '../../../data/repository/profile_user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final TokenRepository tokenRepository;
  final FirebaseAuthRepository firebaseAuthRepository;
  final ProfileUserRepository profileUserRepository;

  AuthBloc({
    required this.authRepository,
    required this.tokenRepository,
    required this.firebaseAuthRepository,
    required this.profileUserRepository,
  }) : super(const AuthStarted()) {
    on<AppStartRequest>((event, emit) async {
      final token = await tokenRepository.getToken();

      if (token != null) {
        emit(const Authenticated());
        // _checkSubscriptionSilently();
      } else {
        emit(const UnAuth());
      }
    });

    on<SignInRequest>((event, emit) async {
      emit(const AuthLoading());
      try {
        AuthToken token = await authRepository.signIn(
          email: event.username,
          password: event.password,
        );

        await tokenRepository.saveToken(token);

        await profileUserRepository.saveProfile(
          profile: ProfileUserModel(
            nameUser: token.nameUser,
            email: token.email,
            phone: token.phone,
            photo: token.photo,
            isPremium: token.isPremium,
          ),
        );

        emit(const Authenticated());
        _checkSubscriptionSilently();
      } catch (e) {
        emit(
          AuthError(
            error: e is RepositoryException ? e.message : e.toString(),
          ),
        );
      }
    });

    on<SingUpRequest>((event, emit) async {
      emit(const AuthLoading());
      try {
        AuthToken token = await authRepository.singUp(
          name: event.name,
          email: event.email,
          password: event.password,
          phone: event.phone,
        );

        await tokenRepository.saveToken(token);

        await profileUserRepository.saveProfile(
          profile: ProfileUserModel(
            nameUser: token.nameUser,
            email: token.email,
            phone: token.phone,
            photo: token.photo,
            isPremium: token.isPremium,
          ),
        );        
        emit(const Authenticated());
        // Verificação silenciosa de assinatura após cadastro
        _checkSubscriptionSilently();
      } catch (e) {
        emit(
          AuthSingUpError(
            error: e is RepositoryException ? e.message : e.toString(),
          ),
        );
      }
    });

    on<SingInGoogleRequest>((event, emit) async {
      emit(const AuthLoading());
      try {
        Map<String, dynamic> userData = await firebaseAuthRepository.signInWithGoogle();
        String idToken = userData['idToken'];

        final (token, wasCreated) = await authRepository.firebaseAuthValid(token: idToken);
        await tokenRepository.saveToken(token);

        await profileUserRepository.saveProfile(
          profile: ProfileUserModel(
            nameUser: token.nameUser,
            email: token.email,
            phone: token.phone,
            photo: token.photo,
            isPremium: token.isPremium,
          ),
        );

        emit(const Authenticated());
        _checkSubscriptionSilently();
      } catch (e) {
        emit(
          AuthError(
            error: e is RepositoryException ? e.message : e.toString(),
          ),
        );
      }
    });

    on<SingInAppleRequest>((event, emit) async {
      emit(const AuthLoading());
      try {
        Map<String, dynamic> userData = await firebaseAuthRepository.signInWithApple();
        String idToken = userData['idToken'];

        final (token, wasCreated) =
            await authRepository.firebaseAuthValid(token: idToken);

        await tokenRepository.saveToken(token);

        await profileUserRepository.saveProfile(
          profile: ProfileUserModel(
            nameUser: token.nameUser,
            email: token.email,
            phone: token.phone,
            photo: token.photo,
            isPremium: token.isPremium,
          ),
        );

        emit(const Authenticated());
        _checkSubscriptionSilently();
      } catch (e) {
        emit(
          AuthError(
            error: e is RepositoryException ? e.message : e.toString(),
          ),
        );
      }
    });

    on<SignOutRequest>((event, emit) async {
      try {
        await firebaseAuthRepository.signOut();
      } catch (e) {
        rethrow;
      }
      
      await tokenRepository.deleteAll();
      await profileUserRepository.deleteProfile();
      emit(const UnAuth());
    });

    on<DeleteAccountRequest>((event, emit) async {
      emit(const AuthLoading());
      try {
        await authRepository.deleteAccount();
        try {
          await firebaseAuthRepository.signOut();
        } catch (e) {
          rethrow;
        }
        
        await tokenRepository.deleteAll();
        await profileUserRepository.deleteProfile();
        emit(const UnAuth());
      } catch (e) {
        emit(
          AuthError(
            error: e is RepositoryException ? e.message : e.toString(),
          ),
        );
      }
    });
  }

  void _checkSubscriptionSilently() {
    // try {
    //   final subscriptionService = GetIt.instance<SubscriptionStatusService>();
    //   subscriptionService.checkSubscriptionStatusOnAppStart();
    // } catch (e) {
    // }
  }
}
