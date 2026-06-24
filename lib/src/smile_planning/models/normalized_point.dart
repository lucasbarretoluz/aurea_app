import 'package:freezed_annotation/freezed_annotation.dart';

part 'normalized_point.freezed.dart';
part 'normalized_point.g.dart';

@freezed
abstract class NormalizedPoint with _$NormalizedPoint {
  const factory NormalizedPoint({
    @Default(0.0) double x,
    @Default(0.0) double y,
  }) = _NormalizedPoint;

  factory NormalizedPoint.fromJson(Map<String, dynamic> json) =>
      _$NormalizedPointFromJson(json);
}
