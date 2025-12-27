import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/logic/bloc/auth/auth_bloc.dart';
import 'package:aurea_app/src/presentation/screens/help/dental_proportions/dental_proportions_page.dart';
import 'package:aurea_app/src/presentation/screens/help/photographic_phone/photographing_with_cellphone_page.dart';
import 'package:aurea_app/src/presentation/screens/help/photographic_protocol/photographic_protocol_page.dart';
import 'package:aurea_app/src/presentation/screens/help/config_camera/semi_professional_camera_settings_page.dart';
import 'package:aurea_app/src/presentation/screens/help/reference_lines/lines_and_references_page.dart';
import 'package:aurea_app/src/presentation/screens/notification/notification_page.dart';
import 'package:aurea_app/src/presentation/screens/patients/handle_patients_page.dart';
import 'package:aurea_app/src/presentation/screens/profile/profile_page.dart';
import 'package:aurea_app/src/presentation/screens/settings/settings_page.dart';
import 'package:aurea_app/src/presentation/screens/sing_up/sing_up_page.dart';
import 'package:aurea_app/src/presentation/screens/support/support_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../screens/home/config_home_page.dart';
import '../screens/login/login_page.dart';
import '../screens/patients/all_patients_page.dart';
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
                child: const ConfigHomePage(),
                transitionsBuilder: (context, animation, _, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
        ),
        GoRoute(
          path: '/notification',
          builder: (context, state) => const NotificationPage(),
        ),
        GoRoute(
          path: '/sing-up',
          builder: (context, state) => const SingUpPage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: '/support',
          builder: (context, state) => const SupportPage(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(
          path: '/all-patients',
          builder: (context, state) => const AllPatientsPage(),
        ),
        GoRoute(
          path: '/help/photographic-protocol',
          builder: (context, state) => const PhotographicProtocolPage(),
        ),
        GoRoute(
          path: '/help/semi-professional-camera-settings',
          builder:
              (context, state) => const SemiProfessionalCameraSettingsPage(),
        ),
        GoRoute(
          path: '/help/photographing-with-cellphone',
          builder: (context, state) => const PhotographingWithCellphonePage(),
        ),
        GoRoute(
          path: '/help/lines-and-references',
          builder: (context, state) => const LinesAndReferencesPage(),
        ),
        GoRoute(
          path: '/help/dental-proportions',
          builder: (context, state) => const DentalProportionsPage(),
        ),
        GoRoute(
          path: '/handle-patients',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            final patient = extra['patient'] as PatientModel;
            return HandlePatientsPage(patient: patient);
          },
        ),
      ],
    );
  }
}
