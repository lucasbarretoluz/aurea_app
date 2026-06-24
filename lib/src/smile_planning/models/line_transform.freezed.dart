// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'line_transform.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LineTransform {

 double get offsetX; double get offsetY; double get angle; double get length;
/// Create a copy of LineTransform
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LineTransformCopyWith<LineTransform> get copyWith => _$LineTransformCopyWithImpl<LineTransform>(this as LineTransform, _$identity);

  /// Serializes this LineTransform to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LineTransform&&(identical(other.offsetX, offsetX) || other.offsetX == offsetX)&&(identical(other.offsetY, offsetY) || other.offsetY == offsetY)&&(identical(other.angle, angle) || other.angle == angle)&&(identical(other.length, length) || other.length == length));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,offsetX,offsetY,angle,length);

@override
String toString() {
  return 'LineTransform(offsetX: $offsetX, offsetY: $offsetY, angle: $angle, length: $length)';
}


}

/// @nodoc
abstract mixin class $LineTransformCopyWith<$Res>  {
  factory $LineTransformCopyWith(LineTransform value, $Res Function(LineTransform) _then) = _$LineTransformCopyWithImpl;
@useResult
$Res call({
 double offsetX, double offsetY, double angle, double length
});




}
/// @nodoc
class _$LineTransformCopyWithImpl<$Res>
    implements $LineTransformCopyWith<$Res> {
  _$LineTransformCopyWithImpl(this._self, this._then);

  final LineTransform _self;
  final $Res Function(LineTransform) _then;

/// Create a copy of LineTransform
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? offsetX = null,Object? offsetY = null,Object? angle = null,Object? length = null,}) {
  return _then(_self.copyWith(
offsetX: null == offsetX ? _self.offsetX : offsetX // ignore: cast_nullable_to_non_nullable
as double,offsetY: null == offsetY ? _self.offsetY : offsetY // ignore: cast_nullable_to_non_nullable
as double,angle: null == angle ? _self.angle : angle // ignore: cast_nullable_to_non_nullable
as double,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _LineTransform implements LineTransform {
  const _LineTransform({this.offsetX = 0.5, this.offsetY = 0.5, this.angle = 0.0, this.length = 0.5});
  factory _LineTransform.fromJson(Map<String, dynamic> json) => _$LineTransformFromJson(json);

@override@JsonKey() final  double offsetX;
@override@JsonKey() final  double offsetY;
@override@JsonKey() final  double angle;
@override@JsonKey() final  double length;

/// Create a copy of LineTransform
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LineTransformCopyWith<_LineTransform> get copyWith => __$LineTransformCopyWithImpl<_LineTransform>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LineTransformToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LineTransform&&(identical(other.offsetX, offsetX) || other.offsetX == offsetX)&&(identical(other.offsetY, offsetY) || other.offsetY == offsetY)&&(identical(other.angle, angle) || other.angle == angle)&&(identical(other.length, length) || other.length == length));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,offsetX,offsetY,angle,length);

@override
String toString() {
  return 'LineTransform(offsetX: $offsetX, offsetY: $offsetY, angle: $angle, length: $length)';
}


}

/// @nodoc
abstract mixin class _$LineTransformCopyWith<$Res> implements $LineTransformCopyWith<$Res> {
  factory _$LineTransformCopyWith(_LineTransform value, $Res Function(_LineTransform) _then) = __$LineTransformCopyWithImpl;
@override @useResult
$Res call({
 double offsetX, double offsetY, double angle, double length
});




}
/// @nodoc
class __$LineTransformCopyWithImpl<$Res>
    implements _$LineTransformCopyWith<$Res> {
  __$LineTransformCopyWithImpl(this._self, this._then);

  final _LineTransform _self;
  final $Res Function(_LineTransform) _then;

/// Create a copy of LineTransform
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? offsetX = null,Object? offsetY = null,Object? angle = null,Object? length = null,}) {
  return _then(_LineTransform(
offsetX: null == offsetX ? _self.offsetX : offsetX // ignore: cast_nullable_to_non_nullable
as double,offsetY: null == offsetY ? _self.offsetY : offsetY // ignore: cast_nullable_to_non_nullable
as double,angle: null == angle ? _self.angle : angle // ignore: cast_nullable_to_non_nullable
as double,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
