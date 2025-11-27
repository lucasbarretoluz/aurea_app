part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.authStarted() = AuthStarted;
  const factory AuthState.unAuth() = UnAuth;
  const factory AuthState.authLoading() = AuthLoading;
  const factory AuthState.authenticated({
    bool? wasCreated,
  }) = Authenticated;

  const factory AuthState.authError({required String error}) = AuthError;
  const factory AuthState.authSingUpError({required String error}) =
      AuthSingUpError;
  const factory AuthState.authenticatedSingUp() = AuthenticatedSingUp;
}
