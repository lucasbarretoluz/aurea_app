import 'package:aurea_app/src/aurea_app.dart';
import 'package:aurea_app/src/core/firebase/firebase_options.dart';
import 'package:aurea_app/src/data/repository/auth_repository.dart';
import 'package:aurea_app/src/data/repository/firebase_auth_repository.dart';
import 'package:aurea_app/src/data/repository/profile_user_repository.dart';
import 'package:aurea_app/src/data/repository/token_repository.dart';
import 'package:aurea_app/src/logic/bloc/auth/auth_bloc.dart';
import 'package:aurea_app/src/logic/cubit/app_bloc_observer.dart';
import 'package:aurea_app/src/presentation/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

final GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await dotenv.load(fileName: '.env.dev');

  getIt.registerSingleton<AuthRepository>(AuthRepository());
  getIt.registerSingleton<TokenRepository>(TokenRepository());
  getIt.registerSingleton<ProfileUserRepository>(ProfileUserRepository());

  getIt.registerSingleton<AuthBloc>(
    AuthBloc(
      authRepository: getIt<AuthRepository>(),
      tokenRepository: getIt<TokenRepository>(),
      firebaseAuthRepository: FirebaseAuthRepository(),
      profileUserRepository: getIt<ProfileUserRepository>(),
    ),
  );

  final storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );

  HydratedBloc.storage = storage;
  Bloc.observer = AppBlocObserver();

  final appRouter = AppRouter();

  runApp(AureaApp(appRouter: appRouter));
}
