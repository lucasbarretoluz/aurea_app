import 'package:aurea_app/src/data/models/exceptions/exceptions.dart';
import 'package:aurea_app/src/data/models/notification/notification_model.dart';
import 'package:aurea_app/src/data/provider/notification_provider.dart';

class NotificationRepository {
  final notificationProvider = NotificationProvider();
  
  Future<List<NotificationModel>> getNotifications() async {
    try {
      final response = await notificationProvider.getNotifications();
      final List<dynamic> data = response.data as List<dynamic>;
      return data.map((e) => NotificationModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw RepositoryException(e.toString());
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      await notificationProvider.markAsRead(notificationId);
    } catch (e) {
      throw RepositoryException(e.toString());
    }
  }
  
  Future<void> markAllAsRead() async {
    try {
      await notificationProvider.markAllAsRead();
    } catch (e) {
      throw RepositoryException(e.toString());
    }
  }
  
  Future<int> getNotificationCount() async {
    try {
      final response = await notificationProvider.getNotificationCount();
      return response.data['count'];
    } catch (e) {
      throw RepositoryException(e.toString());
    }
  }
}