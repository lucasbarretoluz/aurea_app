import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_transform.freezed.dart';
part 'image_transform.g.dart';

@freezed
abstract class ImageTransform with _$ImageTransform {
  const factory ImageTransform({
    @Default(1.0) double scale,
    @Default(0.0) double offsetX,
    @Default(0.0) double offsetY,
  }) = _ImageTransform;

  factory ImageTransform.fromJson(Map<String, dynamic> json) =>
      _$ImageTransformFromJson(json);
}
