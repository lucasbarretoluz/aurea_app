part of 'notification_list_cubit.dart';

@freezed
class NotificationListState with _$NotificationListState {
  const factory NotificationListState.initial() = _Initial;
  const factory NotificationListState.loading() = _Loading;
  const factory NotificationListState.loaded(List<NotificationModel> notifications) = _Loaded;
  const factory NotificationListState.error(String message) = _Error;
}

