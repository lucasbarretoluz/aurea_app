import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/logic/bloc/auth/auth_bloc.dart';
import 'package:aurea_app/src/logic/cubit/clinic/clinic_cubit.dart';
import 'package:aurea_app/src/presentation/screens/help/dental_proportions/dental_proportions_page.dart';
import 'package:aurea_app/src/presentation/screens/patients_add/clinic_patients_page.dart';
import 'package:aurea_app/src/presentation/screens/splash/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aurea_app/src/presentation/screens/help/photographic_phone/photographing_with_cellphone_page.dart';
import 'package:aurea_app/src/presentation/screens/help/photographic_protocol/photographic_protocol_page.dart';
import 'package:aurea_app/src/presentation/screens/help/config_camera/semi_professional_camera_settings_page.dart';
import 'package:aurea_app/src/presentation/screens/help/reference_lines/lines_and_references_page.dart';
import 'package:aurea_app/src/presentation/screens/notification/notification_page.dart';
import 'package:aurea_app/src/presentation/screens/patients_add/new_or_edit_patient_page.dart';
import 'package:aurea_app/src/presentation/screens/patients_handle/patients_handle_page.dart';
import 'package:aurea_app/src/presentation/screens/profile/profile_page.dart';
import 'package:aurea_app/src/presentation/screens/settings/clinics_management_page.dart';
import 'package:aurea_app/src/presentation/screens/settings/settings_page.dart';
import 'package:aurea_app/src/presentation/screens/sing_up/sing_up_page.dart';
import 'package:aurea_app/src/presentation/screens/support/support_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../screens/home/config_home_page.dart';
import '../screens/login/login_page.dart';
import '../screens/patients_add/all_patients_page.dart';
import 'package:aurea_app/src/smile_planning/models/smile_planning_step.dart';
import 'package:aurea_app/src/smile_planning/screens/face_calibration/bipupillary_line_page.dart';
import 'package:aurea_app/src/smile_planning/screens/face_calibration/face_centering_page.dart';
import 'package:aurea_app/src/smile_planning/screens/face_calibration/high_smile_line_page.dart';
import 'package:aurea_app/src/smile_planning/screens/face_calibration/midline_page.dart';
import 'package:aurea_app/src/smile_planning/screens/smile_planning_shell.dart';
import 'package:aurea_app/src/smile_planning/screens/smile_planning_step_page.dart';

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
          path: '/settings/clinics',
          builder: (context, state) => const ClinicsManagementPage(),
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
          path: '/new-or-edit-patient',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>? ?? {};
            final clinicName = extra['clinicName'] as String? ?? '';
            final clinicId = extra['clinicId'] as int? ?? 0;
            final patient = extra['patient'] as PatientModel?;
            final clinicCubit = extra['clinicCubit'] as ClinicCubit?;

            if (clinicCubit != null) {
              return BlocProvider<ClinicCubit>.value(
                value: clinicCubit,
                child: NewOrEditPatientPage(
                  clinicId: clinicId,
                  clinicName: clinicName,
                  patient: patient,
                ),
              );
            }

            return NewOrEditPatientPage(
              clinicId: clinicId,
              clinicName: clinicName,
              patient: patient,
            );
          },
        ),
        GoRoute(
          path: '/clinic-patients',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>? ?? {};
            final clinicName = extra['clinicName'] as String? ?? '';
            final clinicId = extra['clinicId'] as int? ?? 0;
            
            return ClinicPatientsPage(
              clinicName: clinicName,
              clinicId: clinicId,
            );
          },
        ),
        GoRoute(
          path: '/patients-handle',
          builder: (context, state){
            final extra = state.extra as Map<String, dynamic>? ?? {};
            final clinicName = extra['clinicName'] as String? ?? '';
            final clinicId = extra['clinicId'] as int? ?? 0;
            final patient = extra['patient'] as PatientModel;
            return PatientsHandlePage(
              clinicId: clinicId,
              clinicName: clinicName,
              patient: patient,
            );
          },
        ),
        GoRoute(
          path: '/smile-planning',
          redirect: (context, state) {
            if (state.uri.path == '/smile-planning') {
              return '/smile-planning/face/center';
            }
            return null;
          },
          routes: [
            ShellRoute(
              builder: (context, state, child) {
                final launch = parseSmilePlanningExtra(state.extra);
                return SmilePlanningShell(
                  patient: launch?.patient,
                  clinicId: launch?.clinicId,
                  clinicName: launch?.clinicName,
                  photoUrls: launch?.photoUrls ?? const [],
                  selectedPhotoUrl: launch?.selectedPhotoUrl,
                  child: child,
                );
              },
              routes: [
                GoRoute(
                  path: 'face/center',
                  pageBuilder:
                      (context, state) => _faceStepPage(const FaceCenteringPage()),
                ),
                GoRoute(
                  path: 'face/midline',
                  pageBuilder:
                      (context, state) => _faceStepPage(const MidlinePage()),
                ),
                GoRoute(
                  path: 'face/bipupillary',
                  pageBuilder:
                      (context, state) =>
                          _faceStepPage(const BipupillaryLinePage()),
                ),
                GoRoute(
                  path: 'face/high-smile-line',
                  pageBuilder:
                      (context, state) =>
                          _faceStepPage(const HighSmileLinePage()),
                ),
                GoRoute(
                  path: 'smile/photo-select',
                  builder:
                      (context, state) => const SmilePlanningStepPage(
                        step: SmilePlanningStep.smilePhotoSelect,
                      ),
                ),
                GoRoute(
                  path: 'smile/midline',
                  builder:
                      (context, state) => const SmilePlanningStepPage(
                        step: SmilePlanningStep.smileMidline,
                      ),
                ),
                GoRoute(
                  path: 'smile/high-line',
                  builder:
                      (context, state) => const SmilePlanningStepPage(
                        step: SmilePlanningStep.smileHighLine,
                      ),
                ),
                GoRoute(
                  path: 'smile/curve',
                  builder:
                      (context, state) => const SmilePlanningStepPage(
                        step: SmilePlanningStep.smileCurve,
                      ),
                ),
                GoRoute(
                  path: 'design/shape',
                  builder:
                      (context, state) => const SmilePlanningStepPage(
                        step: SmilePlanningStep.designShape,
                      ),
                ),
                GoRoute(
                  path: 'design/adjust',
                  builder:
                      (context, state) => const SmilePlanningStepPage(
                        step: SmilePlanningStep.designAdjust,
                      ),
                ),
                GoRoute(
                  path: 'design/veneer',
                  builder:
                      (context, state) => const SmilePlanningStepPage(
                        step: SmilePlanningStep.designVeneer,
                      ),
                ),
                GoRoute(
                  path: 'design/result',
                  builder:
                      (context, state) => const SmilePlanningStepPage(
                        step: SmilePlanningStep.designResult,
                      ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  static CustomTransitionPage<void> _faceStepPage(Widget child) {
    return CustomTransitionPage<void>(
      transitionDuration: const Duration(milliseconds: 250),
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
