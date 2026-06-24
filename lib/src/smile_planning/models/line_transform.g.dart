// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line_transform.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LineTransform _$LineTransformFromJson(Map<String, dynamic> json) =>
    _LineTransform(
      offsetX: (json['offsetX'] as num?)?.toDouble() ?? 0.5,
      offsetY: (json['offsetY'] as num?)?.toDouble() ?? 0.5,
      angle: (json['angle'] as num?)?.toDouble() ?? 0.0,
      length: (json['length'] as num?)?.toDouble() ?? 0.5,
    );

Map<String, dynamic> _$LineTransformToJson(_LineTransform instance) =>
    <String, dynamic>{
      'offsetX': instance.offsetX,
      'offsetY': instance.offsetY,
      'angle': instance.angle,
      'length': instance.length,
    };
