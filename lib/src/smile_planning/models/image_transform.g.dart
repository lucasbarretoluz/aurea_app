// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_transform.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ImageTransform _$ImageTransformFromJson(Map<String, dynamic> json) =>
    _ImageTransform(
      scale: (json['scale'] as num?)?.toDouble() ?? 1.0,
      offsetX: (json['offsetX'] as num?)?.toDouble() ?? 0.0,
      offsetY: (json['offsetY'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$ImageTransformToJson(_ImageTransform instance) =>
    <String, dynamic>{
      'scale': instance.scale,
      'offsetX': instance.offsetX,
      'offsetY': instance.offsetY,
    };
