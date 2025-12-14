// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    _NotificationModel(
      idNotification: (json['idNotification'] as num).toInt(),
      idUser: (json['idUser'] as num).toInt(),
      title: json['title'] as String,
      message: json['message'] as String,
      icon: json['icon'] as String,
      type: _notificationTypeFromJson(json['type'] as String),
      isRead: json['isRead'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$NotificationModelToJson(_NotificationModel instance) =>
    <String, dynamic>{
      'idNotification': instance.idNotification,
      'idUser': instance.idUser,
      'title': instance.title,
      'message': instance.message,
      'icon': instance.icon,
      'type': _notificationTypeToJson(instance.type),
      'isRead': instance.isRead,
      'createdAt': instance.createdAt.toIso8601String(),
    };
