import 'package:freezed_annotation/freezed_annotation.dart';

enum ReferenceLineType {
  @JsonValue('midline')
  midline,
  @JsonValue('bipupillary')
  bipupillary,
  @JsonValue('highSmileLine')
  highSmileLine,
  @JsonValue('smileCurve')
  smileCurve,
}

enum CalibrationPhase {
  @JsonValue('face')
  face,
  @JsonValue('smile')
  smile,
}
