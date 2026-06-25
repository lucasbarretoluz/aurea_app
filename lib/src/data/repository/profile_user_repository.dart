import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/exceptions/exceptions.dart';
import '../models/profile_user/profile_user_model.dart';
import '../provider/auth_provider.dart';
import '../provider/profile_photo_provider.dart';

class ProfileUserRepository {
  static ProfileUserRepository? _instance;

  factory ProfileUserRepository() =>
      _instance ??= ProfileUserRepository._(const FlutterSecureStorage());

  ProfileUserRepository._(this._storage);

  final FlutterSecureStorage _storage;
  final ProfilePhotoProvider _profilePhotoProvider = ProfilePhotoProvider();
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
    await _storage.delete(key: _photoKey);
    await _storage.delete(key: _isPremiumKey);
  }

  Future<ProfileUserModel> fetchProfileFromApi() async {
    try {
      final response = await _profilePhotoProvider.getProfile();
      if (response.statusCode != 200 || response.data is! Map<String, dynamic>) {
        throw RepositoryException('Erro ao carregar perfil');
      }

      final data = response.data as Map<String, dynamic>;
      final currentProfile = await getProfileData();
      final profile = ProfileUserModel(
        nameUser: data['nameUser'] as String? ?? currentProfile.nameUser,
        email: data['email'] as String? ?? currentProfile.email,
        phone: data['phone'] as String? ?? currentProfile.phone,
        photo: data['photo'] as String?,
        isPremium: data['isPremium'] as bool? ?? currentProfile.isPremium,
      );

      await saveProfile(profile: profile);
      return profile;
    } on DioException catch (e) {
      throw RepositoryException(
        e.response?.data?['message'] ?? 'Erro ao carregar perfil',
      );
    } catch (e) {
      if (e is RepositoryException) rethrow;
      throw RepositoryException('Erro ao carregar perfil: $e');
    }
  }

  Future<String> uploadProfilePhoto({required File imageFile}) async {
    try {
      final response = await _profilePhotoProvider.uploadProfilePhoto(
        imageFile: imageFile,
      );

      if (response.statusCode != 200 || response.data is! Map<String, dynamic>) {
        throw RepositoryException('Erro ao enviar foto de perfil');
      }

      final data = response.data as Map<String, dynamic>;
      final photoUrl = data['photo'] as String? ?? '';

      if (photoUrl.isEmpty) {
        throw RepositoryException('Erro ao enviar foto de perfil');
      }

      final currentProfile = await getProfileData();
      await saveProfile(
        profile: currentProfile.copyWith(photo: photoUrl),
      );

      return photoUrl;
    } on DioException catch (e) {
      throw RepositoryException(
        e.response?.data?['message'] ?? 'Erro ao enviar foto de perfil',
      );
    } catch (e) {
      if (e is RepositoryException) rethrow;
      throw RepositoryException('Erro ao enviar foto de perfil: $e');
    }
  }

  Future<void> persistProfile(ProfileUserModel profile) async {
    await _storage.write(key: _nameKey, value: profile.nameUser);
    await _storage.write(key: _emailKey, value: profile.email);
    await _storage.write(key: _phoneKey, value: profile.phone);
    await _storage.write(key: _photoKey, value: profile.photo);
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
