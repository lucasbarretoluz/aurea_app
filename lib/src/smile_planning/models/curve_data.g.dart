// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curve_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CurveData _$CurveDataFromJson(Map<String, dynamic> json) => _CurveData(
  controlPoints:
      (json['controlPoints'] as List<dynamic>?)
          ?.map((e) => NormalizedPoint.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$CurveDataToJson(_CurveData instance) =>
    <String, dynamic>{'controlPoints': instance.controlPoints};
