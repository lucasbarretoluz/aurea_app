// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smile_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SmilePlan _$SmilePlanFromJson(Map<String, dynamic> json) => _SmilePlan(
  id: json['id'] as String,
  patientId: (json['patientId'] as num).toInt(),
  photoUrl: json['photoUrl'] as String? ?? '',
  referenceLines:
      json['referenceLines'] == null
          ? const ReferenceLines()
          : ReferenceLines.fromJson(
            json['referenceLines'] as Map<String, dynamic>,
          ),
  imageTransform:
      json['imageTransform'] == null
          ? null
          : ImageTransform.fromJson(
            json['imageTransform'] as Map<String, dynamic>,
          ),
  curve:
      json['curve'] == null
          ? null
          : CurveData.fromJson(json['curve'] as Map<String, dynamic>),
  toothShape:
      $enumDecodeNullable(_$ToothShapeEnumMap, json['toothShape']) ??
      ToothShape.oval,
  toothAdjustments:
      (json['toothAdjustments'] as List<dynamic>?)
          ?.map((e) => ToothAdjustment.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  veneerStyleId: json['veneerStyleId'] as String?,
  currentStep:
      $enumDecodeNullable(_$SmilePlanningStepEnumMap, json['currentStep']) ??
      SmilePlanningStep.faceCenter,
  syncStatus:
      $enumDecodeNullable(_$SmilePlanSyncStatusEnumMap, json['syncStatus']) ??
      SmilePlanSyncStatus.localOnly,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  completedAt:
      json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
);

Map<String, dynamic> _$SmilePlanToJson(
  _SmilePlan instance,
) => <String, dynamic>{
  'id': instance.id,
  'patientId': instance.patientId,
  'photoUrl': instance.photoUrl,
  'referenceLines': instance.referenceLines.toJson(),
  'imageTransform': instance.imageTransform?.toJson(),
  'curve': instance.curve?.toJson(),
  'toothShape': _$ToothShapeEnumMap[instance.toothShape]!,
  'toothAdjustments': instance.toothAdjustments.map((e) => e.toJson()).toList(),
  'veneerStyleId': instance.veneerStyleId,
  'currentStep': _$SmilePlanningStepEnumMap[instance.currentStep]!,
  'syncStatus': _$SmilePlanSyncStatusEnumMap[instance.syncStatus]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'completedAt': instance.completedAt?.toIso8601String(),
};

const _$ToothShapeEnumMap = {
  ToothShape.oval: 'oval',
  ToothShape.triangular: 'triangular',
  ToothShape.rectangular: 'rectangular',
  ToothShape.quadrangular: 'quadrangular',
};

const _$SmilePlanningStepEnumMap = {
  SmilePlanningStep.faceCenter: 'faceCenter',
  SmilePlanningStep.faceMidline: 'faceMidline',
  SmilePlanningStep.faceBipupillary: 'faceBipupillary',
  SmilePlanningStep.faceHighSmileLine: 'faceHighSmileLine',
  SmilePlanningStep.smilePhotoSelect: 'smilePhotoSelect',
  SmilePlanningStep.smileMidline: 'smileMidline',
  SmilePlanningStep.smileHighLine: 'smileHighLine',
  SmilePlanningStep.smileCurve: 'smileCurve',
  SmilePlanningStep.designShape: 'designShape',
  SmilePlanningStep.designAdjust: 'designAdjust',
  SmilePlanningStep.designVeneer: 'designVeneer',
  SmilePlanningStep.designResult: 'designResult',
};

const _$SmilePlanSyncStatusEnumMap = {
  SmilePlanSyncStatus.localOnly: 'localOnly',
  SmilePlanSyncStatus.pendingSync: 'pendingSync',
  SmilePlanSyncStatus.synced: 'synced',
};
