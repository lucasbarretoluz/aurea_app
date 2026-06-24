// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference_lines.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReferenceLines _$ReferenceLinesFromJson(Map<String, dynamic> json) =>
    _ReferenceLines(
      faceLines:
          (json['faceLines'] as List<dynamic>?)
              ?.map((e) => ReferenceLine.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      smileLines:
          (json['smileLines'] as List<dynamic>?)
              ?.map((e) => ReferenceLine.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ReferenceLinesToJson(_ReferenceLines instance) =>
    <String, dynamic>{
      'faceLines': instance.faceLines.map((e) => e.toJson()).toList(),
      'smileLines': instance.smileLines.map((e) => e.toJson()).toList(),
    };
