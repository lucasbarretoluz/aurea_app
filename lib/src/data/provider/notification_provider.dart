
import 'package:aurea_app/src/data/api/api.dart';
import 'package:aurea_app/src/data/models/exceptions/exceptions.dart';
import 'package:dio/dio.dart';

class NotificationProvider {
  final Api _api = Api.instance;
  final String _path = '/notifications/';

  Future<Response<dynamic>> getNotifications() async {
    try {
      var response = await _api.dio.get('$_path/getNotifications');
      return response;
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }

  Future<Response<dynamic>> markAsRead(String notificationId) async {
    try {
      var response = await _api.dio.put('$_path/$notificationId/markAsRead');
      return response;
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }

  Future<Response<dynamic>> markAllAsRead() async {
    try {
      var response = await _api.dio.post('$_path/markAllAsRead');
      return response;
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }

  Future<Response<dynamic>> getNotificationCount() async {
    try {
      var response = await _api.dio.get('$_path/count');
      return response;
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }
}