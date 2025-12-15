import 'package:aurea_app/src/data/models/notification/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NotificationModel', () {
    test('should create NotificationModel from JSON', () {
      final json = {
        'idNotification': 1,
        'idUser': 123,
        'title': 'Test Title',
        'message': 'Test Message',
        'icon': 'test_icon',
        'type': 'couple',
        'isRead': false,
        'createdAt': '2024-01-01T00:00:00Z',
      };

      final model = NotificationModel.fromJson(json);

      expect(model.idNotification, 1);
      expect(model.idUser, 123);
      expect(model.title, 'Test Title');
      expect(model.message, 'Test Message');
      expect(model.icon, 'test_icon');
      expect(model.type, NotificationType.couple);
      expect(model.isRead, false);
      expect(model.createdAt, DateTime.parse('2024-01-01T00:00:00Z'));
    });

    test('should convert NotificationModel to JSON', () {
      final model = NotificationModel(
        idNotification: 1,
        idUser: 123,
        title: 'Test Title',
        message: 'Test Message',
        icon: 'test_icon',
        type: NotificationType.system,
        isRead: true,
        createdAt: DateTime.parse('2024-01-01T00:00:00Z'),
      );

      final json = model.toJson();

      expect(json['idNotification'], 1);
      expect(json['idUser'], 123);
      expect(json['title'], 'Test Title');
      expect(json['message'], 'Test Message');
      expect(json['icon'], 'test_icon');
      expect(json['type'], 'system');
      expect(json['isRead'], true);
      expect(json['createdAt'], '2024-01-01T00:00:00.000Z');
    });

    test('should handle all notification types', () {
      final types = [
        NotificationType.couple,
        NotificationType.system,
        NotificationType.update,
        NotificationType.achievement,
      ];

      for (final type in types) {
        final model = NotificationModel(
          idNotification: 1,
          idUser: 123,
          title: 'Test',
          message: 'Test',
          icon: 'icon',
          type: type,
          isRead: false,
          createdAt: DateTime.now(),
        );

        expect(model.type, type);
        final json = model.toJson();
        final fromJson = NotificationModel.fromJson(json);
        expect(fromJson.type, type);
      }
    });

    test('should handle isRead flag correctly', () {
      final readModel = NotificationModel(
        idNotification: 1,
        idUser: 123,
        title: 'Test',
        message: 'Test',
        icon: 'icon',
        type: NotificationType.system,
        isRead: true,
        createdAt: DateTime.now(),
      );

      final unreadModel = NotificationModel(
        idNotification: 2,
        idUser: 123,
        title: 'Test',
        message: 'Test',
        icon: 'icon',
        type: NotificationType.system,
        isRead: false,
        createdAt: DateTime.now(),
      );

      expect(readModel.isRead, true);
      expect(unreadModel.isRead, false);
    });
  });

  group('NotificationType', () {
    test('should parse from string correctly', () {
      expect(NotificationType.fromString('couple'), NotificationType.couple);
      expect(NotificationType.fromString('system'), NotificationType.system);
      expect(NotificationType.fromString('update'), NotificationType.update);
      expect(NotificationType.fromString('achievement'), NotificationType.achievement);
    });

    test('should handle case insensitive parsing', () {
      expect(NotificationType.fromString('COUPLE'), NotificationType.couple);
      expect(NotificationType.fromString('System'), NotificationType.system);
      expect(NotificationType.fromString('UPDATE'), NotificationType.update);
      expect(NotificationType.fromString('Achievement'), NotificationType.achievement);
    });

    test('should return system for unknown types', () {
      expect(NotificationType.fromString('unknown'), NotificationType.system);
      expect(NotificationType.fromString('invalid'), NotificationType.system);
      expect(NotificationType.fromString(''), NotificationType.system);
    });

    test('should return correct name', () {
      expect(NotificationType.couple.name, 'couple');
      expect(NotificationType.system.name, 'system');
      expect(NotificationType.update.name, 'update');
      expect(NotificationType.achievement.name, 'achievement');
    });

    group('getGradientColors', () {
      test('should return correct colors for couple type', () {
        final colorScheme = ColorScheme.light();
        final colors = NotificationType.couple.getGradientColors(colorScheme);
        expect(colors.length, 2);
        expect(colors[0], colorScheme.primary);
        expect(colors[1], colorScheme.secondary);
      });

      test('should return correct colors for system type', () {
        final colorScheme = ColorScheme.light();
        final colors = NotificationType.system.getGradientColors(colorScheme);
        expect(colors.length, 2);
        expect(colors[0], colorScheme.tertiary);
        expect(colors[1], colorScheme.primary);
      });

      test('should return correct colors for update type', () {
        final colorScheme = ColorScheme.light();
        final colors = NotificationType.update.getGradientColors(colorScheme);
        expect(colors.length, 2);
        expect(colors[0], Colors.blue);
        expect(colors[1], Colors.lightBlue);
      });

      test('should return correct colors for achievement type', () {
        final colorScheme = ColorScheme.light();
        final colors = NotificationType.achievement.getGradientColors(colorScheme);
        expect(colors.length, 2);
        expect(colors[0], Colors.amber);
        expect(colors[1], Colors.orange);
      });
    });
  });
}

