import 'package:dio/dio.dart';

class BadRequestException extends DioException {
  final DioException error;
  BadRequestException(this.error) : super(requestOptions: error.requestOptions);

  @override
  String toString() {
    if (error.response != null &&
        (error.response!.data['error'] as String).isNotEmpty) {
      return error.response!.data['error'];
    }
    return 'Requisição inválida';
  }
}

class InternalServerErrorException extends DioException {
  final DioException error;
  InternalServerErrorException(this.error)
      : super(requestOptions: error.requestOptions);

  @override
  String toString() {
    if (error.response != null &&
        (error.response!.data['error'] as String).isNotEmpty) {
      return error.response!.data['error'];
    }
    return 'Um erro desconhecido ocorreu, tente novamente mais tarde';
  }
}

class ConflictException extends DioException {
  final DioException error;
  ConflictException(this.error) : super(requestOptions: error.requestOptions);

  @override
  String toString() {
    if (error.response != null &&
        (error.response!.data['error'] as String).isNotEmpty) {
      return error.response!.data['error'];
    }
    return 'Ocorreu um conflito';
  }
}

class UnauthorizedException extends DioException {
  final DioException error;
  UnauthorizedException(this.error)
      : super(requestOptions: error.requestOptions);

  @override
  String toString() {
    if (error.response != null &&
        (error.response!.data['error'] as String).isNotEmpty) {
      return error.response!.data['error'];
    }
    return 'Acesso negado';
  }
}

class NotFoundException extends DioException {
  final DioException error;
  NotFoundException(this.error) : super(requestOptions: error.requestOptions);

  @override
  String toString() {
    if (error.response != null &&
        (error.response!.data['error'] as String).isNotEmpty) {
      return error.response!.data['error'];
    }
    return 'A informação requisitada não pode ser encontrada';
  }
}

class NoInternetConnectionException extends DioException {
  final DioException error;
  NoInternetConnectionException(this.error)
      : super(requestOptions: error.requestOptions);

  @override
  String toString() {
    if (error.response != null &&
        (error.response!.data['error'] as String).isNotEmpty) {
      return error.response!.data['error'];
    }
    return 'Não foi detectada uma conexão com a internet, tente novamente';
  }
}

class DeadlineExceededException extends DioException {
  final DioException error;
  DeadlineExceededException(this.error)
      : super(requestOptions: error.requestOptions);

  @override
  String toString() {
    if (error.response != null &&
        (error.response!.data['error'] as String).isNotEmpty) {
      return error.response!.data['error'];
    }
    return 'O tempo limite expirou, tente novamente';
  }
}

class TooManyRequestsException extends DioException {
  final DioException error;
  TooManyRequestsException(this.error)
      : super(requestOptions: error.requestOptions) {
  }

  @override
  String toString() {
    if (error.response != null &&
        (error.response!.data['error'] as String).isNotEmpty) {
      return error.response!.data['error'];
    }
    return 'Muitas requisições. Por favor, aguarde ou assine o aplicativo.';
  }
}

class ServiceUnavailableException extends DioException {
  final DioException error;
  ServiceUnavailableException(this.error)
      : super(requestOptions: error.requestOptions);

  @override
  String toString() {
    if (error.response != null &&
        (error.response!.data['error'] as String).isNotEmpty) {
      return error.response!.data['error'];
    }
    return 'Serviço temporariamente indisponível. Por favor, tente novamente mais tarde.';
  }
}
