abstract class CustomException implements Exception {
  final String message;
  const CustomException(this.message) : super();

  @override
  String toString() => message;
}

class RepositoryException extends CustomException {
  RepositoryException(String message) : super(message);
}

class ProviderException extends CustomException {
  ProviderException(String message) : super(message);
}
