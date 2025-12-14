import 'dart:async';
import 'package:aurea_app/src/data/repository/notification_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_state.dart';
part 'notification_cubit.freezed.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository _notificationRepository;
  Timer? _pollingTimer;
  static const Duration _pollingInterval = Duration(minutes: 1);

  NotificationCubit(this._notificationRepository)
      : super(const NotificationState.initial());

  Future<void> initialize() async {
    _startPolling();
  }

  Future<void> fetchNotificationCount({bool initialLoad = false}) async {
    try {
      if (initialLoad) {
        emit(const NotificationState.loading());
      }
      final count = await _notificationRepository.getNotificationCount();
      emit(NotificationState.loaded(count));
    } catch (e) {
      emit(NotificationState.error(e.toString()));
      emit(const NotificationState.loaded(0));
    }
  }

  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(_pollingInterval, (_) {
      fetchNotificationCount();
    });
  }

  void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  void resumePolling() {
    fetchNotificationCount(initialLoad: true);
    _startPolling();
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }
}

