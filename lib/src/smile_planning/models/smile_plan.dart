import 'package:freezed_annotation/freezed_annotation.dart';
import 'curve_data.dart';
import 'image_transform.dart';
import 'reference_lines.dart';
import 'smile_plan_sync_status.dart';
import 'smile_planning_step.dart';
import 'tooth_adjustment.dart';
import 'tooth_shape.dart';

part 'smile_plan.freezed.dart';
part 'smile_plan.g.dart';

@freezed
abstract class SmilePlan with _$SmilePlan {
  @JsonSerializable(explicitToJson: true)
  const factory SmilePlan({
    required String id,
    required int patientId,
    @Default('') String photoUrl,
    @Default(ReferenceLines()) ReferenceLines referenceLines,
    ImageTransform? imageTransform,
    CurveData? curve,
    @Default(ToothShape.oval) ToothShape toothShape,
    @Default([]) List<ToothAdjustment> toothAdjustments,
    String? veneerStyleId,
    @Default(SmilePlanningStep.faceCenter) SmilePlanningStep currentStep,
    @Default(SmilePlanSyncStatus.localOnly) SmilePlanSyncStatus syncStatus,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? completedAt,
  }) = _SmilePlan;

  factory SmilePlan.fromJson(Map<String, dynamic> json) =>
      _$SmilePlanFromJson(json);
}
