import 'package:aurea_app/src/data/models/auth_token/auth_token.dart';
import 'package:aurea_app/src/data/models/profile_user/profile_user_model.dart';

class TestHelpers {
  static AuthToken createMockAuthToken({
    String? accessToken,
    String? refreshToken,
    String? nameUser,
    String? email,
    String? phone,
    bool? isPremium,
  }) {
    return AuthToken(
      accessToken: accessToken ?? 'mock_access_token',
      refreshToken: refreshToken ?? 'mock_refresh_token',
      nameUser: nameUser ?? 'Test User',
      email: email ?? 'test@example.com',
      phone: phone ?? '123456789',
      isPremium: isPremium ?? false,
    );
  }

  static ProfileUserModel createMockProfileUser({
    String? nameUser,
    String? email,
    String? phone,
    String? photo,
    bool? isPremium,
  }) {
    return ProfileUserModel(
      nameUser: nameUser ?? 'Test User',
      email: email ?? 'test@example.com',
      phone: phone ?? '123456789',
      photo: photo,
      isPremium: isPremium ?? false,
    );
  }
}

