part of 'notification_cubit.dart';

@freezed
class NotificationState with _$NotificationState {
  const NotificationState._();
  
  const factory NotificationState.initial() = _Initial;
  const factory NotificationState.loading() = _Loading;
  const factory NotificationState.loaded(int count) = _Loaded;
  const factory NotificationState.error(String message) = _Error;

  int get notificationCount {
    if (this is _Loaded) {
      return (this as _Loaded).count;
    }
    return 0;
  }
}

