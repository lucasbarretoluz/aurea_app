import 'package:freezed_annotation/freezed_annotation.dart';

enum SmilePlanSyncStatus {
  @JsonValue('localOnly')
  localOnly,
  @JsonValue('pendingSync')
  pendingSync,
  @JsonValue('synced')
  synced,
}
