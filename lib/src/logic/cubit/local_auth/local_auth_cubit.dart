import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'local_auth_state.dart';
part 'local_auth_cubit.freezed.dart';

class LocalAuthCubit extends HydratedCubit<LocalAuthState> {
  LocalAuthCubit() : super(const LocalAuthEnabled());

  void enableBiometricAuth() {
    emit(const LocalAuthEnabled());
  }

  void disableBiometricAuth() {
    emit(const LocalAuthDisabled());
  }

  @override
  LocalAuthState? fromJson(Map<String, dynamic> json) {
    try {
      final bool isEnabled = json['isEnabled'] as bool;
      if (isEnabled) {
        return const LocalAuthEnabled();
      } else {
        return const LocalAuthDisabled();
      }
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(LocalAuthState state) {
    try {
      if (state is LocalAuthEnabled) {
        return {'isEnabled': true};
      } else if (state is LocalAuthDisabled) {
        return {'isEnabled': false};
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}
