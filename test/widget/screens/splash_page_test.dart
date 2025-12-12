import 'package:aurea_app/src/logic/bloc/auth/auth_bloc.dart';
import 'package:aurea_app/src/logic/cubit/local_auth/local_auth_cubit.dart';
import 'package:aurea_app/src/presentation/screens/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
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

  group('SplashPage', () {
    testWidgets('should render the splash page', (WidgetTester tester) async {
      final mockAuthBloc = MockAuthBloc();
      when(() => mockAuthBloc.state).thenReturn(const AuthState.authStarted());
      when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());

      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider<AuthBloc>.value(
                  value: mockAuthBloc,
                ),
                BlocProvider<LocalAuthCubit>(
                  create: (context) => LocalAuthCubit(),
                ),
              ],
              child: const SplashScreen(),
            ),
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) => const Scaffold(body: Text('Login')),
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => const Scaffold(body: Text('Home')),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      await tester.pump();
      expect(find.byType(SplashScreen), findsOneWidget);
      
      await tester.pump(const Duration(seconds: 5));
    });
  });
}

