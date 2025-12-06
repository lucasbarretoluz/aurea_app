import 'package:aurea_app/src/logic/bloc/auth/auth_bloc.dart';
import 'package:aurea_app/src/logic/cubit/local_auth/local_auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/types/auth_messages_ios.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AuthState _authState;
  late LocalAuthState _localAuthState;
  LocalAuthentication deviceAuthAPI = LocalAuthentication();

  late AnimationController _fadeController;
  late AnimationController _slideUpController;
  late AnimationController _rotationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideUpAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideUpController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _slideUpAnimation =
        Tween<Offset>(
          begin: const Offset(0, 1.5),
          end: const Offset(0, 0.0),
        ).animate(
          CurvedAnimation(
            parent: _slideUpController,
            curve: Curves.easeOutCubic,
          ),
        );

    _rotationAnimation =
        Tween<double>(
          begin: 0.0,
          end: -1.5708, // -90 graus em radianos (sentido horário)
        ).animate(
          CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut),
        );

    _initAnimate();
  }

  void _initAnimate() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _fadeController.forward();
    _slideUpController.forward();

    await Future.delayed(const Duration(milliseconds: 2500));
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    if (_authState is Authenticated) {
      if (_localAuthState is LocalAuthEnabled) {
        final isAuthenticated = await _requireDeviceAuth();
        if (!mounted) return;

        if (isAuthenticated) {
          context.go('/home');
        } else {
          _navigateToLoginWithAnimation();
        }
      } else {
        context.go('/home');
      }
    } else {
      _navigateToLoginWithAnimation();
    }
  }

  void _navigateToLoginWithAnimation() async {
    _rotationController.forward();
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    context.go('/login');
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideUpController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  Future<bool> _requireDeviceAuth() async {
    bool didAuthenticate = false;
    int attempts = 0;
    try {
      do {
        didAuthenticate = await deviceAuthAPI.authenticate(
          options: const AuthenticationOptions(
            // stickyAuth: true,
            useErrorDialogs: false,
          ),
          localizedReason: 'Por favor, autentique-se para continuar',
          authMessages: const <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: 'Autenticação necessária',
              cancelButton: 'Cancelar',
              biometricHint: "",
            ),
            IOSAuthMessages(cancelButton: 'Cancelar'),
          ],
        );
        attempts++;
      } while (!didAuthenticate && attempts <= 2);

      return didAuthenticate;
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        return false;
      } else if (e.code == auth_error.notEnrolled) {
        return false;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _authState = BlocProvider.of<AuthBloc>(context, listen: true).state;
    _localAuthState = BlocProvider.of<LocalAuthCubit>(
      context,
      listen: true,
    ).state;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(color: Colors.black),
              clipBehavior: Clip.hardEdge,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: AnimatedBuilder(
                  animation: _rotationAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotationAnimation.value, // 90 graus em radianos
                      child: Transform.translate(
                        offset: const Offset(-50, 0),
                        child: Image.asset(
                          'assets/images/tooth_splash.jpg',
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideUpAnimation,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.translate(
                          offset: const Offset(-10, 0),
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Text(
                              'aurea',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 55,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 25,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 30,
                          color: Colors.white,
                          thickness: 2,
                          indent: 3,
                          endIndent: 23,
                        ),
                        RotatedBox(
                          quarterTurns: 1,
                          child: Text(
                            'design app',
                            style: TextStyle(
                              color: Colors.cyan.shade100,
                              fontSize: 35,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 10.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
