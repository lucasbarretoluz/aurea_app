import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.g.dart';
part 'notification_model.freezed.dart';

enum NotificationType {
  couple,
  system,
  update,
  achievement;

  static NotificationType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'couple':
        return NotificationType.couple;
      case 'system':
        return NotificationType.system;
      case 'update':
        return NotificationType.update;
      case 'achievement':
        return NotificationType.achievement;
      default:
        return NotificationType.system;
    }
  }

  List<Color> getGradientColors(ColorScheme colorScheme) {
    switch (this) {
      case NotificationType.couple:
        return [colorScheme.primary, colorScheme.secondary];
      case NotificationType.system:
        return [colorScheme.tertiary, colorScheme.primary];
      case NotificationType.update:
        return [Colors.blue, Colors.lightBlue];
      case NotificationType.achievement:
        return [Colors.amber, Colors.orange];
    }
  }
}

@freezed
abstract class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required int idNotification,
    required int idUser,
    required String title,
    required String message,
    required String icon,
    @JsonKey(fromJson: _notificationTypeFromJson, toJson: _notificationTypeToJson)
    required NotificationType type,
    required bool isRead,
    required DateTime createdAt,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}

NotificationType _notificationTypeFromJson(String type) =>
    NotificationType.fromString(type);

String _notificationTypeToJson(NotificationType type) => type.name;