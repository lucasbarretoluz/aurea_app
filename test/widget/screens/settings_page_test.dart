import 'package:aurea_app/src/logic/bloc/auth/auth_bloc.dart';
import 'package:aurea_app/src/logic/cubit/local_auth/local_auth_cubit.dart';
import 'package:aurea_app/src/presentation/screens/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

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

void main() {
  setUp(() {
    HydratedBloc.storage = MockStorage();
  });

  group('SettingsPage', () {
    testWidgets('should render settings page', (WidgetTester tester) async {
      final mockAuthBloc = MockAuthBloc();
      when(() => mockAuthBloc.state).thenReturn(const AuthState.authenticated());
      when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>.value(
                value: mockAuthBloc,
              ),
              BlocProvider<LocalAuthCubit>(
                create: (context) => LocalAuthCubit(),
              ),
            ],
            child: const SettingsPage(),
          ),
        ),
      );

      expect(find.byType(SettingsPage), findsOneWidget);
      expect(find.text('Configurações'), findsOneWidget);
    });

    testWidgets('should display security section', (WidgetTester tester) async {
      final mockAuthBloc = MockAuthBloc();
      when(() => mockAuthBloc.state).thenReturn(const AuthState.authenticated());
      when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>.value(
                value: mockAuthBloc,
              ),
              BlocProvider<LocalAuthCubit>(
                create: (context) => LocalAuthCubit(),
              ),
            ],
            child: const SettingsPage(),
          ),
        ),
      );

      expect(find.text('Segurança'), findsOneWidget);
      expect(find.text('Autenticação Local'), findsOneWidget);
    });

    testWidgets('should display account section', (WidgetTester tester) async {
      final mockAuthBloc = MockAuthBloc();
      when(() => mockAuthBloc.state).thenReturn(const AuthState.authenticated());
      when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>.value(
                value: mockAuthBloc,
              ),
              BlocProvider<LocalAuthCubit>(
                create: (context) => LocalAuthCubit(),
              ),
            ],
            child: const SettingsPage(),
          ),
        ),
      );

      expect(find.text('Conta'), findsOneWidget);
      expect(find.text('Deletar Conta'), findsOneWidget);
      expect(find.text('Sair'), findsOneWidget);
    });
  });
}

