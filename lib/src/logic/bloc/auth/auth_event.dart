part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.appStartRequest() = AppStartRequest;
  const factory AuthEvent.signInRequest({
    required String username,
    required String password,
  }) = SignInRequest;
  const factory AuthEvent.signOutRequest() = SignOutRequest;
  const factory AuthEvent.singInGoogleRequest() = SingInGoogleRequest;
  const factory AuthEvent.singInAppleRequest() = SingInAppleRequest;
  const factory AuthEvent.singUpRequest({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) = SingUpRequest;
}
