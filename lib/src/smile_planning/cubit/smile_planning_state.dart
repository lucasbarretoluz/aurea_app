part of 'smile_planning_cubit.dart';

@freezed
class SmilePlanningState with _$SmilePlanningState {
  const factory SmilePlanningState.initial() = SmilePlanningInitial;

  const factory SmilePlanningState.stepActive({
    required SmilePlanningStep step,
    required SmilePlan plan,
    required List<String> photoUrls,
    required String activePhotoUrl,
  }) = SmilePlanningStepActive;

  const factory SmilePlanningState.saving() = SmilePlanningSaving;

  const factory SmilePlanningState.completed({required SmilePlan plan}) =
      SmilePlanningCompleted;

  const factory SmilePlanningState.error({required String message}) =
      SmilePlanningError;
}
