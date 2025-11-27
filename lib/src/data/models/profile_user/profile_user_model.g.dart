// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileUserModel _$ProfileUserModelFromJson(Map<String, dynamic> json) =>
    _ProfileUserModel(
      nameUser: json['nameUser'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      isPremium: json['isPremium'] as bool? ?? false,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$ProfileUserModelToJson(_ProfileUserModel instance) =>
    <String, dynamic>{
      'nameUser': instance.nameUser,
      'email': instance.email,
      'phone': instance.phone,
      'isPremium': instance.isPremium,
      'photo': instance.photo,
    };
