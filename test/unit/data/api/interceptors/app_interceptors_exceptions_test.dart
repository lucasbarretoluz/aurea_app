import 'package:aurea_app/src/core/execptions/http_exceptions.dart';
import 'package:aurea_app/src/data/api/interceptors/app_interceptors_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('AppInterceptorsExceptions', () {
    late AppInterceptorsExceptions interceptor;
    late MockDio mockDio;
    late RequestOptions requestOptions;

    setUp(() {
      mockDio = MockDio();
      interceptor = AppInterceptorsExceptions(mockDio);
      requestOptions = RequestOptions(path: '/test');
    });

    group('onRequest', () {
      test('should call handler.next with options', () {
        bool nextCalled = false;
        final handler = _MockRequestInterceptorHandler(
          onNext: (options) {
            nextCalled = true;
            expect(options, requestOptions);
          },
        );

        interceptor.onRequest(requestOptions, handler);

        expect(nextCalled, true);
      });
    });

    group('onError', () {
      test('should convert connectionTimeout to DeadlineExceededException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.connectionTimeout,
        );

        bool rejectCalled = false;
        DioException? rejectedError;
        final handler = _MockErrorInterceptorHandler(
          onReject: (error) {
            rejectCalled = true;
            rejectedError = error;
          },
        );

        interceptor.onError(dioError, handler);

        expect(rejectCalled, true);
        expect(rejectedError, isA<DeadlineExceededException>());
      });

      test('should convert sendTimeout to DeadlineExceededException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.sendTimeout,
        );

        bool rejectCalled = false;
        DioException? rejectedError;
        final handler = _MockErrorInterceptorHandler(
          onReject: (error) {
            rejectCalled = true;
            rejectedError = error;
          },
        );

        interceptor.onError(dioError, handler);

        expect(rejectCalled, true);
        expect(rejectedError, isA<DeadlineExceededException>());
      });

      test('should convert receiveTimeout to DeadlineExceededException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.receiveTimeout,
        );

        bool rejectCalled = false;
        DioException? rejectedError;
        final handler = _MockErrorInterceptorHandler(
          onReject: (error) {
            rejectCalled = true;
            rejectedError = error;
          },
        );

        interceptor.onError(dioError, handler);

        expect(rejectCalled, true);
        expect(rejectedError, isA<DeadlineExceededException>());
      });

      test('should convert 400 status code to BadRequestException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 400,
          ),
        );

        bool rejectCalled = false;
        DioException? rejectedError;
        final handler = _MockErrorInterceptorHandler(
          onReject: (error) {
            rejectCalled = true;
            rejectedError = error;
          },
        );

        interceptor.onError(dioError, handler);

        expect(rejectCalled, true);
        expect(rejectedError, isA<BadRequestException>());
      });

      test('should convert 401 status code to UnauthorizedException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 401,
          ),
        );

        bool rejectCalled = false;
        DioException? rejectedError;
        final handler = _MockErrorInterceptorHandler(
          onReject: (error) {
            rejectCalled = true;
            rejectedError = error;
          },
        );

        interceptor.onError(dioError, handler);

        expect(rejectCalled, true);
        expect(rejectedError, isA<UnauthorizedException>());
      });

      test('should convert 404 status code to NotFoundException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 404,
          ),
        );

        bool rejectCalled = false;
        DioException? rejectedError;
        final handler = _MockErrorInterceptorHandler(
          onReject: (error) {
            rejectCalled = true;
            rejectedError = error;
          },
        );

        interceptor.onError(dioError, handler);

        expect(rejectCalled, true);
        expect(rejectedError, isA<NotFoundException>());
      });

      test('should convert 409 status code to ConflictException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 409,
          ),
        );

        bool rejectCalled = false;
        DioException? rejectedError;
        final handler = _MockErrorInterceptorHandler(
          onReject: (error) {
            rejectCalled = true;
            rejectedError = error;
          },
        );

        interceptor.onError(dioError, handler);

        expect(rejectCalled, true);
        expect(rejectedError, isA<ConflictException>());
      });

      test('should convert 429 status code to TooManyRequestsException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 429,
          ),
        );

        bool rejectCalled = false;
        DioException? rejectedError;
        final handler = _MockErrorInterceptorHandler(
          onReject: (error) {
            rejectCalled = true;
            rejectedError = error;
          },
        );

        interceptor.onError(dioError, handler);

        expect(rejectCalled, true);
        expect(rejectedError, isA<TooManyRequestsException>());
      });

      test('should convert 500 status code to InternalServerErrorException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 500,
          ),
        );

        bool rejectCalled = false;
        DioException? rejectedError;
        final handler = _MockErrorInterceptorHandler(
          onReject: (error) {
            rejectCalled = true;
            rejectedError = error;
          },
        );

        interceptor.onError(dioError, handler);

        expect(rejectCalled, true);
        expect(rejectedError, isA<InternalServerErrorException>());
      });

      test('should convert 503 status code to ServiceUnavailableException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 503,
          ),
        );

        bool rejectCalled = false;
        DioException? rejectedError;
        final handler = _MockErrorInterceptorHandler(
          onReject: (error) {
            rejectCalled = true;
            rejectedError = error;
          },
        );

        interceptor.onError(dioError, handler);

        expect(rejectCalled, true);
        expect(rejectedError, isA<ServiceUnavailableException>());
      });

      test('should pass through cancel type without conversion', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.cancel,
        );

        bool nextCalled = false;
        final handler = _MockErrorInterceptorHandler(
          onNext: (error) {
            nextCalled = true;
            expect(error, dioError);
          },
        );

        interceptor.onError(dioError, handler);

        expect(nextCalled, true);
      });

      test('should convert unknown type to NoInternetConnectionException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.unknown,
        );

        bool rejectCalled = false;
        DioException? rejectedError;
        final handler = _MockErrorInterceptorHandler(
          onReject: (error) {
            rejectCalled = true;
            rejectedError = error;
          },
        );

        interceptor.onError(dioError, handler);

        expect(rejectCalled, true);
        expect(rejectedError, isA<NoInternetConnectionException>());
      });

      test('should convert badCertificate type to BadCertificateException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badCertificate,
        );

        bool rejectCalled = false;
        DioException? rejectedError;
        final handler = _MockErrorInterceptorHandler(
          onReject: (error) {
            rejectCalled = true;
            rejectedError = error;
          },
        );

        interceptor.onError(dioError, handler);

        expect(rejectCalled, true);
        expect(rejectedError, isA<BadCertificateException>());
      });

      test('should convert connectionError type to NoInternetConnectionException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.connectionError,
        );

        bool rejectCalled = false;
        DioException? rejectedError;
        final handler = _MockErrorInterceptorHandler(
          onReject: (error) {
            rejectCalled = true;
            rejectedError = error;
          },
        );

        interceptor.onError(dioError, handler);

        expect(rejectCalled, true);
        expect(rejectedError, isA<NoInternetConnectionException>());
      });

      test('should pass through unhandled badResponse without conversion', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 418,
          ),
        );

        bool nextCalled = false;
        final handler = _MockErrorInterceptorHandler(
          onNext: (error) {
            nextCalled = true;
            expect(error, dioError);
          },
        );

        interceptor.onError(dioError, handler);

        expect(nextCalled, true);
      });
    });
  });
}

class _MockRequestInterceptorHandler extends RequestInterceptorHandler {
  final void Function(RequestOptions options) onNext;

  _MockRequestInterceptorHandler({required this.onNext});

  @override
  void next(RequestOptions options) {
    onNext(options);
  }
}

class _MockErrorInterceptorHandler extends ErrorInterceptorHandler {
  final void Function(DioException error)? onReject;
  final void Function(DioException error)? onNext;

  _MockErrorInterceptorHandler({
    this.onReject,
    this.onNext,
  });

  @override
  void reject(DioException error, [bool callFollowingErrorInterceptor = true]) {
    onReject?.call(error);
  }

  @override
  void next(DioException error) {
    onNext?.call(error);
  }
}

