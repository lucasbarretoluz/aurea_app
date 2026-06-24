// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_transform.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImageTransform {

 double get scale; double get offsetX; double get offsetY;
/// Create a copy of ImageTransform
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageTransformCopyWith<ImageTransform> get copyWith => _$ImageTransformCopyWithImpl<ImageTransform>(this as ImageTransform, _$identity);

  /// Serializes this ImageTransform to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageTransform&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.offsetX, offsetX) || other.offsetX == offsetX)&&(identical(other.offsetY, offsetY) || other.offsetY == offsetY));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scale,offsetX,offsetY);

@override
String toString() {
  return 'ImageTransform(scale: $scale, offsetX: $offsetX, offsetY: $offsetY)';
}


}

/// @nodoc
abstract mixin class $ImageTransformCopyWith<$Res>  {
  factory $ImageTransformCopyWith(ImageTransform value, $Res Function(ImageTransform) _then) = _$ImageTransformCopyWithImpl;
@useResult
$Res call({
 double scale, double offsetX, double offsetY
});




}
/// @nodoc
class _$ImageTransformCopyWithImpl<$Res>
    implements $ImageTransformCopyWith<$Res> {
  _$ImageTransformCopyWithImpl(this._self, this._then);

  final ImageTransform _self;
  final $Res Function(ImageTransform) _then;

/// Create a copy of ImageTransform
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scale = null,Object? offsetX = null,Object? offsetY = null,}) {
  return _then(_self.copyWith(
scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,offsetX: null == offsetX ? _self.offsetX : offsetX // ignore: cast_nullable_to_non_nullable
as double,offsetY: null == offsetY ? _self.offsetY : offsetY // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ImageTransform implements ImageTransform {
  const _ImageTransform({this.scale = 1.0, this.offsetX = 0.0, this.offsetY = 0.0});
  factory _ImageTransform.fromJson(Map<String, dynamic> json) => _$ImageTransformFromJson(json);

@override@JsonKey() final  double scale;
@override@JsonKey() final  double offsetX;
@override@JsonKey() final  double offsetY;

/// Create a copy of ImageTransform
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageTransformCopyWith<_ImageTransform> get copyWith => __$ImageTransformCopyWithImpl<_ImageTransform>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageTransformToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageTransform&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.offsetX, offsetX) || other.offsetX == offsetX)&&(identical(other.offsetY, offsetY) || other.offsetY == offsetY));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scale,offsetX,offsetY);

@override
String toString() {
  return 'ImageTransform(scale: $scale, offsetX: $offsetX, offsetY: $offsetY)';
}


}

/// @nodoc
abstract mixin class _$ImageTransformCopyWith<$Res> implements $ImageTransformCopyWith<$Res> {
  factory _$ImageTransformCopyWith(_ImageTransform value, $Res Function(_ImageTransform) _then) = __$ImageTransformCopyWithImpl;
@override @useResult
$Res call({
 double scale, double offsetX, double offsetY
});




}
/// @nodoc
class __$ImageTransformCopyWithImpl<$Res>
    implements _$ImageTransformCopyWith<$Res> {
  __$ImageTransformCopyWithImpl(this._self, this._then);

  final _ImageTransform _self;
  final $Res Function(_ImageTransform) _then;

/// Create a copy of ImageTransform
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scale = null,Object? offsetX = null,Object? offsetY = null,}) {
  return _then(_ImageTransform(
scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,offsetX: null == offsetX ? _self.offsetX : offsetX // ignore: cast_nullable_to_non_nullable
as double,offsetY: null == offsetY ? _self.offsetY : offsetY // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
