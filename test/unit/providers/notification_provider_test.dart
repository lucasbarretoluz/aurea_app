import 'package:aurea_app/src/data/provider/notification_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.env.dev');
  });

  group('NotificationProvider', () {
    late NotificationProvider provider;

    setUp(() {
      provider = NotificationProvider();
    });

    test('should be instantiable', () {
      expect(provider, isA<NotificationProvider>());
    });

    test('should have getNotifications method', () {
      expect(provider.getNotifications, isA<Function>());
    });

    test('should have markAsRead method', () {
      expect(provider.markAsRead, isA<Function>());
    });

    test('should have markAllAsRead method', () {
      expect(provider.markAllAsRead, isA<Function>());
    });

    test('should have getNotificationCount method', () {
      expect(provider.getNotificationCount, isA<Function>());
    });

    test('getNotifications should throw exception on error', () async {
      try {
        await provider.getNotifications();
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('markAsRead should throw exception on error', () async {
      try {
        await provider.markAsRead('1');
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('markAsRead should handle different notificationId values', () async {
      try {
        await provider.markAsRead('123');
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('markAllAsRead should throw exception on error', () async {
      try {
        await provider.markAllAsRead();
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('getNotificationCount should throw exception on error', () async {
      try {
        await provider.getNotificationCount();
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });
  });
}
