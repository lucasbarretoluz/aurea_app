import 'package:aurea_app/src/presentation/router/router.dart';
import 'package:aurea_app/src/presentation/widgets/toast/custom_toast.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import '../../../logic/bloc/auth/auth_bloc.dart';
import '../../models/auth_token/auth_token.dart';
import '../../repository/token_repository.dart';

class RevokeTokenException implements Exception {
  final String message;
  const RevokeTokenException(
    this.message,
  );
}

class AppInterceptorsRefreshToken extends QueuedInterceptorsWrapper {
  final Dio _dio;

  final _secureStorage = TokenRepository();
  final GetIt _getIt = GetIt.instance;

  AppInterceptorsRefreshToken(this._dio);

  @override
  void onRequest(options, handler) async {
    try {
      final token = await _secureStorage.getTokenData();

      if (token.refreshToken == null || token.accessToken!.isEmpty) {
        return handler.next(options);
      }

      options.headers['Authorization'] = 'bearer ${token.accessToken}';

      return handler.next(options);
    } catch (e) {
      return handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode != 401) {
      return handler.next(response);
    }
    try {
      final refreshResponse = await _tryRefresh(response);
      handler.resolve(refreshResponse);
    } on RevokeTokenException {
      _signOutUser();
      handler.reject(DioException(
        requestOptions: response.requestOptions,
        response: response,
      ));
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        _signOutUser();
      }
      handler.reject(error);
    }
  }

  @override
  void onError(err, handler) async {
    var token = await _secureStorage.getTokenData();

    if (err.response?.statusCode == 401 && token.accessToken != null) {
      final response = err.response;
      try {
        final refreshResponse = await _tryRefresh(response!);
        handler.resolve(refreshResponse);
        return; 
      } on RevokeTokenException {
        _signOutUser();
        return;
      } on DioException catch (error) {
        if (error.response?.statusCode == 401) {
          _signOutUser();
          return;
        }
        handler.next(error);
        return;
      }
    }
    return handler.next(err);
  }

  void _signOutUser() {
    _getIt.get<AuthBloc>().add(const SignOutRequest());
    final context = navigatorKey.currentContext;
    if (context != null) {
      showToast(
        context: context,
        title: 'Sessão expirada',
        description: 'Por favor, faça login novamente',
        type: ToastificationType.warning,
        autoCloseDuration: const Duration(seconds: 5),
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        if (navigatorKey.currentContext != null) {
          context.go('/login');
        }
      });
    }
  }

  Future<Response<dynamic>> _tryRefresh(Response response) async {
    final Dio tokenDio = Dio(BaseOptions(baseUrl: _dio.options.baseUrl));

    late AuthToken? refreshedToken;

    try {
      refreshedToken = await getNewToken(tokenDio);
    } on RevokeTokenException catch (error) {
      _signOutUser();
      throw DioException(
        requestOptions: response.requestOptions,
        error: error,
        response: response,
      );
    }
    if (refreshedToken != null) {
      await _secureStorage.saveToken(refreshedToken);
    }
    return tokenDio.request<dynamic>(
      response.requestOptions.path,
      cancelToken: response.requestOptions.cancelToken,
      data: response.requestOptions.data,
      onReceiveProgress: response.requestOptions.onReceiveProgress,
      onSendProgress: response.requestOptions.onSendProgress,
      queryParameters: response.requestOptions.queryParameters,
      options: Options(
        method: response.requestOptions.method,
        sendTimeout: response.requestOptions.sendTimeout,
        receiveTimeout: response.requestOptions.receiveTimeout,
        extra: response.requestOptions.extra,
        headers: response.requestOptions.headers
          ..addAll(
              {'Authorization': 'bearer ${refreshedToken?.accessToken ?? ''}'}),
        responseType: response.requestOptions.responseType,
        contentType: response.requestOptions.contentType,
        validateStatus: response.requestOptions.validateStatus,
        receiveDataWhenStatusError:
            response.requestOptions.receiveDataWhenStatusError,
        followRedirects: response.requestOptions.followRedirects,
        maxRedirects: response.requestOptions.maxRedirects,
        requestEncoder: response.requestOptions.requestEncoder,
        responseDecoder: response.requestOptions.responseDecoder,
        listFormat: response.requestOptions.listFormat,
      ),
    );
  }

  Future<AuthToken?> getNewToken(Dio dio) async {
    var token = await _secureStorage.getTokenData();
    try {
      final response = await dio.post(
        '/identity/user/refreshToken',
        data: {
          'refreshToken': token.refreshToken,
        },
      );
      final refreshedToken =
          AuthToken.fromJson(response.data as Map<String, dynamic>);
      return refreshedToken;
    } catch (error) {
      throw RevokeTokenException(error.toString());
    }
  }
}
