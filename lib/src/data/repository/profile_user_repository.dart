import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/profile_user/profile_user_model.dart';
import '../provider/auth_provider.dart';

class ProfileUserRepository {
  static ProfileUserRepository? _instance;

  factory ProfileUserRepository() =>
      _instance ??= ProfileUserRepository._(const FlutterSecureStorage());

  ProfileUserRepository._(this._storage);

  final FlutterSecureStorage _storage;
  static const _nameKey = 'NAME_USER_PROFILE';
  static const _emailKey = 'EMAIL_USER_PROFILE';
  static const _phoneKey = 'PHONE_USER_PROFILE';
  static const _photoKey = 'PHOTO_USER_PROFILE';
  static const _isPremiumKey = 'IS_PREMIUM_USER_PROFILE';

  Future<void> saveProfile({
    required ProfileUserModel profile,
  }) async {
    try {
      await _storage.write(key: _nameKey, value: profile.nameUser);
      await _storage.write(key: _emailKey, value: profile.email);
      await _storage.write(key: _phoneKey, value: profile.phone);
      await _storage.write(key: _photoKey, value: profile.photo);
      await _storage.write(
          key: _isPremiumKey, value: profile.isPremium ? 'true' : 'false');
    } catch (e) {

      try {
        await _storage.deleteAll();
        
        await _storage.write(key: _nameKey, value: profile.nameUser);
        await _storage.write(key: _emailKey, value: profile.email);
        await _storage.write(key: _phoneKey, value: profile.phone);
        await _storage.write(key: _photoKey, value: profile.photo);
        await _storage.write(
            key: _isPremiumKey, value: profile.isPremium ? 'true' : 'false');
      } catch (retryError) {
      }
    }
  }

  Future<ProfileUserModel> getProfileData() async {
    try {
      final nameUser = await _storage.read(key: _nameKey);
      final email = await _storage.read(key: _emailKey);
      final phone = await _storage.read(key: _phoneKey);
      final photo = await _storage.read(key: _photoKey);
      final isPremium = await _storage.read(key: _isPremiumKey);

      return ProfileUserModel(
        nameUser: nameUser ?? '',
        email: email ?? '',
        phone: phone ?? '',
        photo: photo,
        isPremium: isPremium == 'true',
      );
    } catch (e) {
      
      try {
        await _storage.deleteAll();
        
        final nameUser = await _storage.read(key: _nameKey);
        final email = await _storage.read(key: _emailKey);
        final phone = await _storage.read(key: _phoneKey);
        final photo = await _storage.read(key: _photoKey);
        final isPremium = await _storage.read(key: _isPremiumKey);
        
        return ProfileUserModel(
          nameUser: nameUser ?? '',
          email: email ?? '',
          phone: phone ?? '',
          photo: photo,
          isPremium: isPremium == 'true',
        );
      } catch (retryError) {
        return ProfileUserModel(
          nameUser: '',
          email: '',
          phone: '',
          photo: null,
          isPremium: false,
        );
      }
    }
  }

  Future<void> deleteProfile() async {
    await _storage.delete(key: _nameKey);
    await _storage.delete(key: _emailKey);
    await _storage.delete(key: _phoneKey);
    await _storage.delete(key: _isPremiumKey);
  }

  Future<void> persistProfile(ProfileUserModel profile) async {
    await _storage.write(key: _nameKey, value: profile.nameUser);
    await _storage.write(key: _emailKey, value: profile.email);
    await _storage.write(key: _phoneKey, value: profile.phone);
    await _storage.write(
        key: _isPremiumKey, value: profile.isPremium ? 'true' : 'false');
  }

  Future<void> updateIsPremium(bool isPremium) async {
    final previousIsPremium = await _storage.read(key: _isPremiumKey);
    
    try {
      final authProvider = AuthProvider();
      await authProvider.updateIsPremium(isPremium: isPremium);
      
      await _storage.write(key: _isPremiumKey, value: isPremium ? 'true' : 'false');
    } catch (e) {
      if (previousIsPremium != null) {
        await _storage.write(key: _isPremiumKey, value: previousIsPremium);
      }
      throw Exception('Falha ao atualizar status premium na API: $e');
    }
  }
}
