import 'package:freezed_annotation/freezed_annotation.dart';
import 'line_transform.dart';

part 'tooth_adjustment.freezed.dart';
part 'tooth_adjustment.g.dart';

@freezed
abstract class ToothAdjustment with _$ToothAdjustment {
  @JsonSerializable(explicitToJson: true)
  const factory ToothAdjustment({
    @Default(0) int toothIndex,
    @Default(LineTransform()) LineTransform transform,
  }) = _ToothAdjustment;

  factory ToothAdjustment.fromJson(Map<String, dynamic> json) =>
      _$ToothAdjustmentFromJson(json);
}
