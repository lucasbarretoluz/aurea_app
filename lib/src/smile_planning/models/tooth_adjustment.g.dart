// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tooth_adjustment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ToothAdjustment _$ToothAdjustmentFromJson(Map<String, dynamic> json) =>
    _ToothAdjustment(
      toothIndex: (json['toothIndex'] as num?)?.toInt() ?? 0,
      transform:
          json['transform'] == null
              ? const LineTransform()
              : LineTransform.fromJson(
                json['transform'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$ToothAdjustmentToJson(_ToothAdjustment instance) =>
    <String, dynamic>{
      'toothIndex': instance.toothIndex,
      'transform': instance.transform.toJson(),
    };
