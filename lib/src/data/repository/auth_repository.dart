import '../models/auth_token/auth_token.dart';
import '../models/exceptions/exceptions.dart';
import '../provider/auth_provider.dart';

class AuthRepository {
  final authProvider = AuthProvider();

  Future<AuthToken> signIn({
    required String email,
    required String password,
    String? domain,
  }) async {
    try {
      final result = await authProvider.signIn(
        identifier: email,
        password: password,
      );

      final jwtToken = AuthToken.fromJson(result.data);

      return jwtToken;
    } catch (e) {
      throw RepositoryException(
          e is ProviderException ? e.message : e.toString());
    }
  }

  Future<AuthToken> singUp({
    required String name,
    required String email,
    required String password,
     String? phone,
  }) async {
    try {
      final result = await authProvider.singUp(
        name: name,
        email: email,
        password: password,
        phone: phone,
      );

      final jwtToken = AuthToken.fromJson(result.data);

      return jwtToken;
    } catch (e) {
      throw RepositoryException(
          e is ProviderException ? e.message : e.toString());
    }
  }

  Future<(AuthToken, bool)> firebaseAuthValid({required String token}) async {
    try {
      final result = await authProvider.firebaseAuthValid(token: token);

      final userJson = result.data['user'];
      bool wasCreated = result.data['wasCreated'] ?? false;

      final jwtToken = AuthToken.fromJson(userJson);

      return (jwtToken, wasCreated);
    } catch (e) {
      throw RepositoryException(
        e is ProviderException ? e.message : e.toString(),
      );
    }
  }

  Future<void> deleteAccount() async {
    try {
      await authProvider.deleteAccount();
    } catch (e) {
      throw RepositoryException(
          e is ProviderException ? e.message : e.toString());
    }
  }

  Future<void> clearAccount() async {
    try {
      await authProvider.clearAccount();
    } catch (e) {
      throw RepositoryException(
          e is ProviderException ? e.message : e.toString());
    }
  }

  Future<AuthToken> updateIsPremium({required bool isPremium}) async {
    try {
      final result = await authProvider.updateIsPremium(isPremium: isPremium);

      final updatedToken = AuthToken.fromJson(result.data);

      return updatedToken;
    } catch (e) {
      throw RepositoryException(
          e is ProviderException ? e.message : e.toString());
    }
  }

  Future<AuthToken> refreshToken({required String refreshToken}) async {
    try {
      final result = await authProvider.refreshToken(refreshToken: refreshToken);

      final newToken = AuthToken.fromJson(result.data);

      return newToken;
    } catch (e) {
      throw RepositoryException(
          e is ProviderException ? e.message : e.toString());
    }
  }
}
