import 'package:freezed_annotation/freezed_annotation.dart';
import 'reference_line.dart';

part 'reference_lines.freezed.dart';
part 'reference_lines.g.dart';

@freezed
abstract class ReferenceLines with _$ReferenceLines {
  @JsonSerializable(explicitToJson: true)
  const factory ReferenceLines({
    @Default([]) List<ReferenceLine> faceLines,
    @Default([]) List<ReferenceLine> smileLines,
  }) = _ReferenceLines;

  factory ReferenceLines.fromJson(Map<String, dynamic> json) =>
      _$ReferenceLinesFromJson(json);
}
