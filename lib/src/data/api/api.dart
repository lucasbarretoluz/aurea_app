import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'interceptors/app_interceptors_exceptions.dart';
import 'interceptors/app_interceptors_refresh_token.dart';

class Api {
  static final Api _instance = Api._internal();
  static Api get instance => _instance;

  late final Dio dio;

  Api._internal() {
    dio = _createDio();
  }

  Dio _createDio() {
    final baseUrl = dotenv.env['BASE_URL'] ?? '';
    if (baseUrl.isEmpty) {
      throw Exception('BASE_URL não está configurada no .env.dev');
    }
    var dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    dio.options.connectTimeout = const Duration(seconds: 60);
    dio.options.receiveTimeout = const Duration(seconds: 60);
    dio.options.sendTimeout = const Duration(seconds: 60);

    dio.interceptors.addAll({
      AppInterceptorsRefreshToken(dio),
      AppInterceptorsExceptions(dio),
    });
    return dio;
  }
}
