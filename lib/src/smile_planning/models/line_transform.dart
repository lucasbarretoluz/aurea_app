import 'package:freezed_annotation/freezed_annotation.dart';

part 'line_transform.freezed.dart';
part 'line_transform.g.dart';

@freezed
abstract class LineTransform with _$LineTransform {
  const factory LineTransform({
    @Default(0.5) double offsetX,
    @Default(0.5) double offsetY,
    @Default(0.0) double angle,
    @Default(0.5) double length,
  }) = _LineTransform;

  factory LineTransform.fromJson(Map<String, dynamic> json) =>
      _$LineTransformFromJson(json);
}
