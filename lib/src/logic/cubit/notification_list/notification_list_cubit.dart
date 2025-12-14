import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:aurea_app/src/data/models/notification/notification_model.dart';
import 'package:aurea_app/src/data/repository/notification_repository.dart';

part 'notification_list_state.dart';
part 'notification_list_cubit.freezed.dart';


class NotificationListCubit extends Cubit<NotificationListState> {
  final NotificationRepository _notificationRepository;

  NotificationListCubit(this._notificationRepository)
      : super(const NotificationListState.initial());

  Future<void> fetchNotifications() async {
    try {
      emit(const NotificationListState.loading());
      final notifications = await _notificationRepository.getNotifications();
      emit(NotificationListState.loaded(notifications));
    } catch (e) {
      emit(NotificationListState.error(e.toString()));
    }
  }

  Future<void> markAsRead(int notificationId) async {
    final currentState = state;
    if (currentState is _Loaded) {
      try {
        await _notificationRepository.markAsRead(notificationId.toString());
        
        final updatedNotifications = currentState.notifications.map((notification) {
          if (notification.idNotification == notificationId) {
            return notification.copyWith(isRead: true);
          }
          return notification;
        }).toList();

        emit(NotificationListState.loaded(updatedNotifications));
      } catch (e) {
        emit(NotificationListState.error(e.toString()));
      }
    }
  }

  Future<void> markAllAsRead() async {
    final currentState = state;
    if (currentState is _Loaded) {
      try {
        await _notificationRepository.markAllAsRead();
        
        final updatedNotifications = currentState.notifications.map((notification) {
          return notification.copyWith(isRead: true);
        }).toList();

        emit(NotificationListState.loaded(updatedNotifications));
      } catch (e) {
        emit(NotificationListState.error(e.toString()));
      }
    }
  }

  void deleteNotification(int notificationId) {
    final currentState = state;
    if (currentState is _Loaded) {
      final updatedNotifications = currentState.notifications
          .where((notification) => notification.idNotification != notificationId)
          .toList();

      emit(NotificationListState.loaded(updatedNotifications));
    }
  }

  void refresh() {
    fetchNotifications();
  }
}

