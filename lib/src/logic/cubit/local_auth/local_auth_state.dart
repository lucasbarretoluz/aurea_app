part of 'local_auth_cubit.dart';

@freezed
class LocalAuthState with _$LocalAuthState {
  const factory LocalAuthState.localAuthInitial() = LocalAuthInitial;
  const factory LocalAuthState.localAuthEnabled() = LocalAuthEnabled;
  const factory LocalAuthState.localAuthDisabled() = LocalAuthDisabled;
}
