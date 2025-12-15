import 'package:aurea_app/src/data/models/exceptions/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';

class _TestCustomException extends CustomException {
  const _TestCustomException(String message) : super(message);
}

void main() {
  group('CustomException', () {
    test('deve armazenar e retornar a mensagem correta', () {
      const exception = _TestCustomException('mensagem de erro');

      expect(exception.message, 'mensagem de erro');
      expect(exception.toString(), 'mensagem de erro');
    });

    test('deve implementar Exception', () {
      const exception = _TestCustomException('erro');

      expect(exception, isA<Exception>());
    });
  });

  group('RepositoryException', () {
    test('deve estender CustomException e implementar Exception', () {
      final exception = RepositoryException('erro repo');

      expect(exception, isA<RepositoryException>());
      expect(exception, isA<CustomException>());
      expect(exception, isA<Exception>());
    });

    test('deve retornar a mensagem correta no toString', () {
      final exception = RepositoryException('erro do repositório');

      expect(exception.message, 'erro do repositório');
      expect(exception.toString(), 'erro do repositório');
    });
  });

  group('ProviderException', () {
    test('deve estender CustomException e implementar Exception', () {
      final exception = ProviderException('erro provider');

      expect(exception, isA<ProviderException>());
      expect(exception, isA<CustomException>());
      expect(exception, isA<Exception>());
    });

    test('deve retornar a mensagem correta no toString', () {
      final exception = ProviderException('erro do provider');

      expect(exception.message, 'erro do provider');
      expect(exception.toString(), 'erro do provider');
    });
  });
}


