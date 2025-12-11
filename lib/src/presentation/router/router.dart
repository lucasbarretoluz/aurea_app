import 'package:aurea_app/src/logic/bloc/auth/auth_bloc.dart';
import 'package:aurea_app/src/presentation/screens/profile/profile_page.dart';
import 'package:aurea_app/src/presentation/screens/sing_up/sing_up_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../screens/home/home_page.dart';
import '../screens/login/login_page.dart';
import '../screens/splash/splash_page.dart';

final GetIt getIt = GetIt.instance;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  final GoRouter router;

  AppRouter() : router = _createRouter();

  static GoRouter _createRouter() {
    AuthBloc authBloc = getIt<AuthBloc>();

    return GoRouter(
      navigatorKey: navigatorKey,
      redirect: (context, state) {
        final isAuth = authBloc.state is Authenticated;
        final isUnAuth = authBloc.state is UnAuth;

        final isLogin = state.uri == '/login';
        final isHome = state.uri == '/home';
        final isSingUP = state.fullPath == '/sing-up';

        if (isUnAuth && !isSingUP) {
          return '/login';
        }

        if (isAuth && isLogin) {
          return '/home';
        }

        if (isUnAuth && isHome) {
          return '/login';
        }

        return null;
      },
      routes: <RouteBase>[
        GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
        GoRoute(
          path: '/home',
          pageBuilder:
              (context, state) => CustomTransitionPage<void>(
                transitionDuration: const Duration(milliseconds: 1000),
                child: const HomePage(),
                transitionsBuilder: (context, animation, _, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
        ),
        GoRoute(
          path: '/sing-up',
          builder: (context, state) => const SingUpPage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    );
  }
}
