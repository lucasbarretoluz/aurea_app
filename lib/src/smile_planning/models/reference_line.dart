import 'package:freezed_annotation/freezed_annotation.dart';
import 'line_transform.dart';
import 'reference_line_type.dart';

part 'reference_line.freezed.dart';
part 'reference_line.g.dart';

@freezed
abstract class ReferenceLine with _$ReferenceLine {
  @JsonSerializable(explicitToJson: true)
  const factory ReferenceLine({
    required ReferenceLineType type,
    required CalibrationPhase phase,
    @Default(LineTransform()) LineTransform transform,
  }) = _ReferenceLine;

  factory ReferenceLine.fromJson(Map<String, dynamic> json) =>
      _$ReferenceLineFromJson(json);
}
