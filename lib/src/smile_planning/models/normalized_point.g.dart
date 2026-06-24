// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'normalized_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NormalizedPoint _$NormalizedPointFromJson(Map<String, dynamic> json) =>
    _NormalizedPoint(
      x: (json['x'] as num?)?.toDouble() ?? 0.0,
      y: (json['y'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$NormalizedPointToJson(_NormalizedPoint instance) =>
    <String, dynamic>{'x': instance.x, 'y': instance.y};
