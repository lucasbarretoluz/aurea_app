import 'package:dio/dio.dart';

import '../../../core/execptions/http_exceptions.dart';


class AppInterceptorsExceptions extends Interceptor {
  final Dio dio;

  AppInterceptorsExceptions(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(err);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err);
          case 401:
            throw UnauthorizedException(err);
          case 404:
            throw NotFoundException(err);
          case 409:
            throw ConflictException(err);
          case 429:
            throw TooManyRequestsException(err);
          case 503:
            throw ServiceUnavailableException(err);
          case 500:
            throw InternalServerErrorException(err);
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        throw NoInternetConnectionException(err);
      case DioExceptionType.badCertificate:
        throw InternalServerErrorException(err);
      case DioExceptionType.connectionError:
        throw NoInternetConnectionException(err);
    }

    return handler.next(err);
  }
}
