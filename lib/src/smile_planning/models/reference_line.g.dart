// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReferenceLine _$ReferenceLineFromJson(Map<String, dynamic> json) =>
    _ReferenceLine(
      type: $enumDecode(_$ReferenceLineTypeEnumMap, json['type']),
      phase: $enumDecode(_$CalibrationPhaseEnumMap, json['phase']),
      transform:
          json['transform'] == null
              ? const LineTransform()
              : LineTransform.fromJson(
                json['transform'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$ReferenceLineToJson(_ReferenceLine instance) =>
    <String, dynamic>{
      'type': _$ReferenceLineTypeEnumMap[instance.type]!,
      'phase': _$CalibrationPhaseEnumMap[instance.phase]!,
      'transform': instance.transform.toJson(),
    };

const _$ReferenceLineTypeEnumMap = {
  ReferenceLineType.midline: 'midline',
  ReferenceLineType.bipupillary: 'bipupillary',
  ReferenceLineType.highSmileLine: 'highSmileLine',
  ReferenceLineType.smileCurve: 'smileCurve',
};

const _$CalibrationPhaseEnumMap = {
  CalibrationPhase.face: 'face',
  CalibrationPhase.smile: 'smile',
};
