import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/auth_token/auth_token.dart';

class TokenRepository {
  static TokenRepository? _instance;

  factory TokenRepository() =>
      _instance ??= TokenRepository._(const FlutterSecureStorage());

  TokenRepository._(this._storage);

  final FlutterSecureStorage _storage;
  static const _tokenKey = 'TOKEN';
  static const _refreshToken = 'REFRESH_TOKEN';
  static const _expiration = 'EXPIRATION';

  Future<void> saveToken(AuthToken token) async {
    try {
      await _storage.write(key: _tokenKey, value: token.accessToken);
      await _storage.write(key: _refreshToken, value: token.refreshToken);
    } catch (e) {
      try {
        await _storage.deleteAll();
        
        await _storage.write(key: _tokenKey, value: token.accessToken);
        await _storage.write(key: _refreshToken, value: token.refreshToken);
      } catch (retryError) {
      }
    }
  }

  Future<AuthToken> getTokenData() async {
    try {
      final accessToken = await _storage.read(key: _tokenKey);
      final refreshToken = await _storage.read(key: _refreshToken);

      return AuthToken(
        accessToken: accessToken ?? '',
        refreshToken: refreshToken ?? '',
      );
    } catch (e) {
      try {
        await _storage.deleteAll();
        
        final accessToken = await _storage.read(key: _tokenKey);
        final refreshToken = await _storage.read(key: _refreshToken);
        
        return AuthToken(
          accessToken: accessToken ?? '',
          refreshToken: refreshToken ?? '',
        );
      } catch (retryError) {
        return AuthToken(
          accessToken: '',
          refreshToken: '',
        );
      }
    }
  }

  Future<bool> hasToken() async {
    var value = await _storage.read(key: _tokenKey);
    return value != null;
  }

  Future<void> deleteToken() async {
    return _storage.delete(key: _tokenKey);
  }

  Future<String?> getToken() async {
    return _storage.read(key: _tokenKey);
  }

  Future<String?> getRefreshToken() async {
    return _storage.read(key: _refreshToken);
  }

  Future<int?> getExpiration() async {
    return int.parse(await _storage.read(key: _expiration) ?? '');
  }

  Future<void> persistToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<bool> shouldRefresh() async {
    return false;
  }

  Future<void> deleteAll() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _refreshToken);
    await _storage.delete(key: _expiration);
  }

  Future<void> clearAllAppData() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      await deleteAll();
    }
  }
}
