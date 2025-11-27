// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthToken _$AuthTokenFromJson(Map<String, dynamic> json) => _AuthToken(
  accessToken: json['accessToken'] as String?,
  refreshToken: json['refreshToken'] as String?,
  nameUser: json['nameUser'] as String? ?? '',
  email: json['email'] as String? ?? '',
  phone: json['phone'] as String? ?? '',
  isPremium: json['isPremium'] as bool? ?? false,
);

Map<String, dynamic> _$AuthTokenToJson(_AuthToken instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'nameUser': instance.nameUser,
      'email': instance.email,
      'phone': instance.phone,
      'isPremium': instance.isPremium,
    };
