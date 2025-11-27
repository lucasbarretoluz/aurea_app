import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../models/exceptions/exceptions.dart';

class FirebaseAuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {      
      await GoogleSignInPlatform.instance.init(
        InitParameters(
          serverClientId: '636764141599-nfn9g70tou4ns6ni142bl6cc7ejpf189.apps.googleusercontent.com',
        ),
      );
            
      final AuthenticationResults result = await GoogleSignInPlatform.instance
          .authenticate(const AuthenticateParameters());
      
      
      final GoogleSignInUserData googleUser = result.user;
      
      final ClientAuthorizationTokenData? tokens = await GoogleSignInPlatform
          .instance
          .clientAuthorizationTokensForScopes(
              ClientAuthorizationTokensForScopesParameters(
                  request: AuthorizationRequestDetails(
                      scopes: const ['email', 'profile'],
                      userId: googleUser.id,
                      email: googleUser.email,
                      promptIfUnauthorized: false)));


      if (tokens == null) {
        throw ProviderException("Erro ao obter tokens do Google");
      }
      
      if (tokens.accessToken.isEmpty) {
        throw ProviderException("Access token inválido ou vazio");
      }

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: tokens.accessToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final String? idToken = await userCredential.user?.getIdToken();
      
      if (idToken == null) {
        throw ProviderException("Erro ao fazer login com Google");
      }

      return {
        'idToken': idToken,
        'photoUrl': googleUser.photoUrl,
        'displayName': googleUser.displayName,
        'email': googleUser.email,
      };
    } catch (e, _) {
      if (e.toString().contains('network_error') || e.toString().contains('NETWORK_ERROR')) {
        throw ProviderException("Erro de conexão. Verifique sua internet.");
      } else if (e.toString().contains('sign_in_canceled') || e.toString().contains('canceled') || e.toString().contains('sign_in_cancelled')) {
        throw ProviderException("Login cancelado. Verifique se há uma conta Google configurada no dispositivo e se as permissões estão corretas.");
      } else if (e.toString().contains('play_services_not_available')) {
        throw ProviderException("Google Play Services não disponível");
      } else if (e is ProviderException) {
        rethrow;
      } else {
        throw ProviderException("Erro ao fazer login com Google: ${e.toString()}");
      }
    }
  }

  Future<Map<String, dynamic>> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
      );

      if (credential.identityToken == null) {
        throw Exception("Erro ao fazer login na Apple");
      }

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(oauthCredential);

      String displayName = '';
      if (credential.givenName != null && credential.familyName != null) {
        displayName = '${credential.givenName} ${credential.familyName}';
      }

      final String? idToken = await userCredential.user?.getIdToken();
      if (idToken == null) {
        throw Exception("Erro ao fazer login na Apple");
      }

      return {
        'idToken': idToken,
        'photoUrl': null,
        'displayName': displayName,
        'email': credential.email,
      };
    } catch (e) {
      if (e.toString().contains('canceled') || e.toString().contains('cancelled')) {
        throw ProviderException("Login cancelado");
      } else if (e is ProviderException) {
        rethrow;
      } else {
        throw ProviderException("Erro ao fazer login com Apple: ${e.toString()}");
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await GoogleSignIn.instance.signOut();
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }
}
