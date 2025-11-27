import 'package:aurea_app/src/core/theme/light.dart';
import 'package:aurea_app/src/logic/bloc/auth/auth_bloc.dart';
import 'package:aurea_app/src/presentation/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:toastification/toastification.dart';

import 'logic/cubit/local_auth/local_auth_cubit.dart';

class ExclusiveApp extends StatelessWidget {
  final AppRouter appRouter;
  const ExclusiveApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocalAuthCubit()),
        BlocProvider(
          create: (context) =>
              GetIt.I<AuthBloc>()..add(const AppStartRequest()),
        ),
      ],
      child: ExclusiveAppView(appRouter: appRouter),
    );
  }
}

class ExclusiveAppView extends StatefulWidget {
  final AppRouter appRouter;
  const ExclusiveAppView({super.key, required this.appRouter});

  @override
  State<ExclusiveAppView> createState() => _ExclusiveAppViewState();
}

class _ExclusiveAppViewState extends State<ExclusiveAppView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // NotificationCubit é gerenciado apenas na HomePage
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: ToastificationWrapper(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: lightTheme(),
          themeMode: ThemeMode.light,
          routerConfig: widget.appRouter.router,
        ),
      ),
    );
  }
}
