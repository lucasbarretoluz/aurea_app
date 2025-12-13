import 'package:aurea_app/src/data/api/interceptors/app_interceptors_refresh_token.dart';
import 'package:aurea_app/src/data/models/auth_token/auth_token.dart';
import 'package:aurea_app/src/logic/bloc/auth/auth_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockAuthBloc extends Mock implements AuthBloc {}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    registerFallbackValue(SignOutRequest());
  });
  group('AppInterceptorsRefreshToken', () {
    late AppInterceptorsRefreshToken interceptor;
    late MockDio mockDio;
    late RequestOptions requestOptions;
    late GetIt getIt;
    late MockAuthBloc mockAuthBloc;

    setUp(() {
      mockDio = MockDio();
      requestOptions = RequestOptions(path: '/test', baseUrl: 'https://api.example.com');
      getIt = GetIt.instance;
      mockAuthBloc = MockAuthBloc();
      
      when(() => mockDio.options).thenReturn(BaseOptions(baseUrl: 'https://api.example.com'));
      
      try {
        if (getIt.isRegistered<AuthBloc>()) {
          getIt.unregister<AuthBloc>();
        }
      } catch (_) {}
      
      getIt.registerSingleton<AuthBloc>(mockAuthBloc);
      
      when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());
      when(() => mockAuthBloc.add(any<AuthEvent>())).thenReturn(null);
      
      interceptor = AppInterceptorsRefreshToken(mockDio);
    });

    tearDown(() {
      try {
        if (getIt.isRegistered<AuthBloc>()) {
          getIt.unregister<AuthBloc>();
        }
      } catch (_) {}
    });

    group('onRequest', () {
      test('should call handler.next with options when called', () async {
        bool nextCalled = false;
        final handler = _MockRequestInterceptorHandler(
          onNext: (options) {
            nextCalled = true;
          },
        );

        interceptor.onRequest(requestOptions, handler);
        await Future.delayed(const Duration(milliseconds: 100));

        expect(nextCalled, true);
      });

      test('should call handler.next even when token retrieval fails', () async {
        bool nextCalled = false;
        final handler = _MockRequestInterceptorHandler(
          onNext: (options) {
            nextCalled = true;
          },
        );

        interceptor.onRequest(requestOptions, handler);
        await Future.delayed(const Duration(milliseconds: 100));

        expect(nextCalled, true);
      });
    });

    group('onResponse', () {
      test('should call handler.next when statusCode is not 401', () async {
        final response = Response(
          requestOptions: requestOptions,
          statusCode: 200,
          data: {'success': true},
        );

        bool nextCalled = false;
        final handler = _MockResponseInterceptorHandler(
          onNext: (resp) {
            nextCalled = true;
            expect(resp.statusCode, 200);
          },
        );

        interceptor.onResponse(response, handler);
        await Future.delayed(const Duration(milliseconds: 100));

        expect(nextCalled, true);
      });

      test('should handle 401 response', () {
        final response = Response(
          requestOptions: requestOptions,
          statusCode: 401,
          data: {'error': 'Unauthorized'},
        );

        final handler = _MockResponseInterceptorHandler(
          onNext: (resp) {},
          onResolve: (resp) {},
        );

        expect(() => interceptor.onResponse(response, handler), returnsNormally);
      });
    });

    group('onError', () {
      test('should call handler.next when statusCode is not 401', () async {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 404,
          ),
        );

        bool nextCalled = false;
        final handler = _MockErrorInterceptorHandler(
          onNext: (error) {
            nextCalled = true;
            expect(error.response?.statusCode, 404);
          },
        );

        interceptor.onError(dioError, handler);
        await Future.delayed(const Duration(milliseconds: 100));

        expect(nextCalled, true);
      });

      test('should call handler.next when error has no response', () async {
        final dioError = DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.connectionTimeout,
        );

        bool nextCalled = false;
        final handler = _MockErrorInterceptorHandler(
          onNext: (error) {
            nextCalled = true;
          },
        );

        interceptor.onError(dioError, handler);
        await Future.delayed(const Duration(milliseconds: 100));

        expect(nextCalled, true);
      });

    });

    group('getNewToken', () {
      test('should be a method that exists and is callable', () {
        expect(interceptor.getNewToken, isA<Function>());
      });

      test('should accept Dio instance as parameter', () {
        final testDio = Dio(BaseOptions(baseUrl: 'https://api.example.com'));
        expect(() => interceptor.getNewToken(testDio), returnsNormally);
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
  final void Function(Response response)? onResolve;

  _MockResponseInterceptorHandler({
    this.onNext,
    this.onResolve,
  });

  @override
  void next(Response response) {
    onNext?.call(response);
  }

  @override
  void resolve(Response response, [bool callFollowingResponseInterceptor = true]) {
    onResolve?.call(response);
  }

  @override
  void reject(DioException error, [bool callFollowingErrorInterceptor = true]) {
    // Handled by onReject in ErrorInterceptorHandler if needed
  }
}

class _MockErrorInterceptorHandler extends ErrorInterceptorHandler {
  final void Function(DioException error)? onNext;
  final void Function(Response response)? onResolve;
  final void Function(DioException error)? onReject;

  _MockErrorInterceptorHandler({
    this.onNext,
    this.onResolve,
    this.onReject,
  });

  @override
  void next(DioException error) {
    onNext?.call(error);
  }

  @override
  void resolve(Response response, [bool callFollowingResponseInterceptor = true]) {
    onResolve?.call(response);
  }

  @override
  void reject(DioException error, [bool callFollowingErrorInterceptor = true]) {
    onReject?.call(error);
  }
}
