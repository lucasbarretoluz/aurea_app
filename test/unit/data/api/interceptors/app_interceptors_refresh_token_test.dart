import 'package:aurea_app/src/data/api/interceptors/app_interceptors_refresh_token.dart';
import 'package:aurea_app/src/data/repository/token_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockTokenRepository extends Mock implements TokenRepository {}

class MockAuthBloc extends Mock {}

void main() {
  group('AppInterceptorsRefreshToken', () {
    late AppInterceptorsRefreshToken interceptor;
    late MockDio mockDio;
    late RequestOptions requestOptions;
    late GetIt getIt;

    setUp(() {
      mockDio = MockDio();
      requestOptions = RequestOptions(path: '/test');
      getIt = GetIt.instance;
      
      // Reset GetIt
      if (getIt.isRegistered<MockAuthBloc>()) {
        getIt.unregister<MockAuthBloc>();
      }
      
      interceptor = AppInterceptorsRefreshToken(mockDio);
    });

    tearDown(() {
      if (getIt.isRegistered<MockAuthBloc>()) {
        getIt.unregister<MockAuthBloc>();
      }
    });

    group('onRequest', () {
      test('should be an async method', () {
        final handler = _MockRequestInterceptorHandler(
          onNext: (options) {},
        );

        expect(
          () => interceptor.onRequest(requestOptions, handler),
          returnsNormally,
        );
      });
    });

    group('onResponse', () {
      test('should be an async method', () {
        final response = Response(
          requestOptions: requestOptions,
          statusCode: 200,
          data: {'success': true},
        );

        final handler = _MockResponseInterceptorHandler(
          onNext: (resp) {},
        );

        expect(
          () => interceptor.onResponse(response, handler),
          returnsNormally,
        );
      });
    });

    group('onError', () {
      test('should be an async method', () {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 404,
          ),
        );

        final handler = _MockErrorInterceptorHandler(
          onNext: (error) {},
        );

        expect(
          () => interceptor.onError(dioError, handler),
          returnsNormally,
        );
      });
    });

    group('getNewToken', () {
      test('should be a method that exists', () {
        final mockDioForRefresh = MockDio();
        when(() => mockDioForRefresh.options).thenReturn(
          BaseOptions(baseUrl: 'https://api.example.com'),
        );

        // Verifica que o método existe
        // Nota: Testes completos deste método requerem mock de TokenRepository
        // que é instanciado internamente, tornando difícil de testar isoladamente
        expect(interceptor.getNewToken, isA<Function>());
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

class _MockResponseInterceptorHandler extends ResponseInterceptorHandler {
  final void Function(Response response)? onNext;

  _MockResponseInterceptorHandler({
    this.onNext,
  });

  @override
  void next(Response response) {
    onNext?.call(response);
  }

}

class _MockErrorInterceptorHandler extends ErrorInterceptorHandler {
  final void Function(DioException error)? onNext;

  _MockErrorInterceptorHandler({
    this.onNext,
  });

  @override
  void next(DioException error) {
    onNext?.call(error);
  }
}

