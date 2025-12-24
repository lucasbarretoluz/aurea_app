import 'package:aurea_app/src/core/execptions/http_exceptions.dart';
import 'package:dio/dio.dart';


class AppInterceptorsExceptions extends Interceptor {
  final Dio dio;

  AppInterceptorsExceptions(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    DioException customException;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        customException = DeadlineExceededException(err);
        return handler.reject(customException);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            customException = BadRequestException(err);
            return handler.reject(customException);
          case 401:
            customException = UnauthorizedException(err);
            return handler.reject(customException);
          case 404:
            customException = NotFoundException(err);
            return handler.reject(customException);
          case 409:
            customException = ConflictException(err);
            return handler.reject(customException);
          case 429:
            customException = TooManyRequestsException(err);
            return handler.reject(customException);
          case 503:
            customException = ServiceUnavailableException(err);
            return handler.reject(customException);
          case 500:
            customException = InternalServerErrorException(err);
            return handler.reject(customException);
        }
        break;
      case DioExceptionType.cancel:
        return handler.next(err);
      case DioExceptionType.unknown:
        customException = NoInternetConnectionException(err);
        return handler.reject(customException);
      case DioExceptionType.badCertificate:
        customException = BadCertificateException(err);
        return handler.reject(customException);
      case DioExceptionType.connectionError:
        customException = NoInternetConnectionException(err);
        return handler.reject(customException);
    }

    return handler.next(err);
  }
}
