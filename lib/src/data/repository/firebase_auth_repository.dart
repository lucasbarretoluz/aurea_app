import '../models/exceptions/exceptions.dart';
import '../provider/firebase_auth_provider.dart';

class FirebaseAuthRepository {
  final firebaseAuthProvider = FirebaseAuthProvider();

  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      final result = await firebaseAuthProvider.signInWithGoogle();
      return result;
    } catch (e) {
      throw RepositoryException(
          e is ProviderException ? e.message : e.toString());
    }
  }

  Future<Map<String, dynamic>> signInWithApple() async {
    try {
      return await firebaseAuthProvider.signInWithApple();
    } catch (e) {
      throw RepositoryException(
          e is ProviderException ? e.message : e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await firebaseAuthProvider.signOut();
    } catch (e) {
      throw RepositoryException(
          e is ProviderException ? e.message : e.toString());
    }
  }
}
