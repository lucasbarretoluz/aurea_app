import 'package:aurea_app/src/logic/cubit/local_auth/local_auth_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

void main() {
  setUp(() {
    HydratedBloc.storage = MockStorage();
  });

  group('LocalAuthCubit', () {
    test('initial state should be LocalAuthEnabled', () {
      final cubit = LocalAuthCubit();
      expect(cubit.state, isA<LocalAuthEnabled>());
      cubit.close();
    });

    blocTest<LocalAuthCubit, LocalAuthState>(
      'should emit LocalAuthDisabled when disableBiometricAuth is called',
      build: () => LocalAuthCubit(),
      act: (cubit) => cubit.disableBiometricAuth(),
      expect: () => [isA<LocalAuthDisabled>()],
    );

    blocTest<LocalAuthCubit, LocalAuthState>(
      'should emit LocalAuthEnabled when enableBiometricAuth is called',
      build: () => LocalAuthCubit(),
      act: (cubit) => cubit.enableBiometricAuth(),
      expect: () => [isA<LocalAuthEnabled>()],
    );
  });
}

class MockStorage extends Storage {
  @override
  dynamic read(String key) => <String, dynamic>{};

  @override
  Future<void> write(String key, dynamic value) async {}

  @override
  Future<void> delete(String key) async {}

  @override
  Future<void> clear() async {}

  @override
  Future<void> close() async {}
}

