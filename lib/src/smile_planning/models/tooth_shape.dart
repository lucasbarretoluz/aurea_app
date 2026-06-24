import 'package:freezed_annotation/freezed_annotation.dart';

enum ToothShape {
  @JsonValue('oval')
  oval,
  @JsonValue('triangular')
  triangular,
  @JsonValue('rectangular')
  rectangular,
  @JsonValue('quadrangular')
  quadrangular,
}
