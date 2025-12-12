import 'package:aurea_app/src/core/execptions/http_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HTTP Exceptions', () {
    late RequestOptions requestOptions;

    setUp(() {
      requestOptions = RequestOptions(path: '/test');
    });

    group('BadRequestException', () {
      test('should create BadRequestException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 400,
            data: {'error': 'Bad request error'},
          ),
        );

        final exception = BadRequestException(dioError);

        expect(exception, isA<BadRequestException>());
        expect(exception, isA<DioException>());
        expect(exception.error, dioError);
      });

      test('should return error message from response when available', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 400,
            data: {'error': 'Custom error message'},
          ),
        );

        final exception = BadRequestException(dioError);

        expect(exception.toString(), 'Custom error message');
      });

      test('should return default message when response is null', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.connectionTimeout,
        );

        final exception = BadRequestException(dioError);

        expect(exception.toString(), 'Requisição inválida');
      });

      test('should return default message when error field is empty', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 400,
            data: {'error': ''},
          ),
        );

        final exception = BadRequestException(dioError);

        expect(exception.toString(), 'Requisição inválida');
      });
    });

    group('InternalServerErrorException', () {
      test('should create InternalServerErrorException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
        );

        final exception = InternalServerErrorException(dioError);

        expect(exception, isA<InternalServerErrorException>());
        expect(exception.error, dioError);
      });

      test('should return error message from response when available', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 500,
            data: {'error': 'Server error occurred'},
          ),
        );

        final exception = InternalServerErrorException(dioError);

        expect(exception.toString(), 'Server error occurred');
      });

      test('should return default message when response is null', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.connectionTimeout,
        );

        final exception = InternalServerErrorException(dioError);

        expect(exception.toString(), 'Um erro desconhecido ocorreu, tente novamente mais tarde');
      });
    });

    group('ConflictException', () {
      test('should create ConflictException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
        );

        final exception = ConflictException(dioError);

        expect(exception, isA<ConflictException>());
        expect(exception.error, dioError);
      });

      test('should return error message from response when available', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 409,
            data: {'error': 'Resource conflict'},
          ),
        );

        final exception = ConflictException(dioError);

        expect(exception.toString(), 'Resource conflict');
      });

      test('should return default message when response is null', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.connectionTimeout,
        );

        final exception = ConflictException(dioError);

        expect(exception.toString(), 'Ocorreu um conflito');
      });
    });

    group('UnauthorizedException', () {
      test('should create UnauthorizedException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
        );

        final exception = UnauthorizedException(dioError);

        expect(exception, isA<UnauthorizedException>());
        expect(exception.error, dioError);
      });

      test('should return error message from response when available', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 401,
            data: {'error': 'Unauthorized access'},
          ),
        );

        final exception = UnauthorizedException(dioError);

        expect(exception.toString(), 'Unauthorized access');
      });

      test('should return default message when response is null', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.connectionTimeout,
        );

        final exception = UnauthorizedException(dioError);

        expect(exception.toString(), 'Acesso negado');
      });
    });

    group('NotFoundException', () {
      test('should create NotFoundException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
        );

        final exception = NotFoundException(dioError);

        expect(exception, isA<NotFoundException>());
        expect(exception.error, dioError);
      });

      test('should return error message from response when available', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 404,
            data: {'error': 'Resource not found'},
          ),
        );

        final exception = NotFoundException(dioError);

        expect(exception.toString(), 'Resource not found');
      });

      test('should return default message when response is null', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.connectionTimeout,
        );

        final exception = NotFoundException(dioError);

        expect(exception.toString(), 'A informação requisitada não pode ser encontrada');
      });
    });

    group('NoInternetConnectionException', () {
      test('should create NoInternetConnectionException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.connectionError,
        );

        final exception = NoInternetConnectionException(dioError);

        expect(exception, isA<NoInternetConnectionException>());
        expect(exception.error, dioError);
      });

      test('should return error message from response when available', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.connectionError,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 0,
            data: {'error': 'No internet connection'},
          ),
        );

        final exception = NoInternetConnectionException(dioError);

        expect(exception.toString(), 'No internet connection');
      });

      test('should return default message when response is null', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.connectionError,
        );

        final exception = NoInternetConnectionException(dioError);

        expect(exception.toString(), 'Não foi detectada uma conexão com a internet, tente novamente');
      });
    });

    group('DeadlineExceededException', () {
      test('should create DeadlineExceededException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.sendTimeout,
        );

        final exception = DeadlineExceededException(dioError);

        expect(exception, isA<DeadlineExceededException>());
        expect(exception.error, dioError);
      });

      test('should return error message from response when available', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.sendTimeout,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 408,
            data: {'error': 'Request timeout'},
          ),
        );

        final exception = DeadlineExceededException(dioError);

        expect(exception.toString(), 'Request timeout');
      });

      test('should return default message when response is null', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.sendTimeout,
        );

        final exception = DeadlineExceededException(dioError);

        expect(exception.toString(), 'O tempo limite expirou, tente novamente');
      });
    });

    group('TooManyRequestsException', () {
      test('should create TooManyRequestsException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
        );

        final exception = TooManyRequestsException(dioError);

        expect(exception, isA<TooManyRequestsException>());
        expect(exception.error, dioError);
      });

      test('should return error message from response when available', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 429,
            data: {'error': 'Rate limit exceeded'},
          ),
        );

        final exception = TooManyRequestsException(dioError);

        expect(exception.toString(), 'Rate limit exceeded');
      });

      test('should return default message when response is null', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.connectionTimeout,
        );

        final exception = TooManyRequestsException(dioError);

        expect(exception.toString(), 'Muitas requisições. Por favor, aguarde ou assine o aplicativo.');
      });
    });

    group('ServiceUnavailableException', () {
      test('should create ServiceUnavailableException', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
        );

        final exception = ServiceUnavailableException(dioError);

        expect(exception, isA<ServiceUnavailableException>());
        expect(exception.error, dioError);
      });

      test('should return error message from response when available', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 503,
            data: {'error': 'Service unavailable'},
          ),
        );

        final exception = ServiceUnavailableException(dioError);

        expect(exception.toString(), 'Service unavailable');
      });

      test('should return default message when response is null', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.connectionTimeout,
        );

        final exception = ServiceUnavailableException(dioError);

        expect(exception.toString(), 'Serviço temporariamente indisponível. Por favor, tente novamente mais tarde.');
      });
    });
  });
}

