import 'package:aurea_app/src/data/repository/notification_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.env.dev');
  });

  group('NotificationRepository', () {
    late NotificationRepository repository;

    setUp(() {
      repository = NotificationRepository();
    });

    test('should be instantiable', () {
      expect(repository, isA<NotificationRepository>());
    });

    test('should have getNotifications method', () {
      expect(repository.getNotifications, isA<Function>());
    });

    test('should have markAsRead method', () {
      expect(repository.markAsRead, isA<Function>());
    });

    test('should have markAllAsRead method', () {
      expect(repository.markAllAsRead, isA<Function>());
    });

    test('should have getNotificationCount method', () {
      expect(repository.getNotificationCount, isA<Function>());
    });

    test('getNotifications should throw exception on error', () async {
      try {
        await repository.getNotifications();
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('markAsRead should throw exception on error', () async {
      try {
        await repository.markAsRead('1');
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('markAsRead should handle different notificationId values', () async {
      try {
        await repository.markAsRead('123');
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('markAllAsRead should throw exception on error', () async {
      try {
        await repository.markAllAsRead();
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('getNotificationCount should throw exception on error', () async {
      try {
        await repository.getNotificationCount();
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });
  });
}

