// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'normalized_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NormalizedPoint {

 double get x; double get y;
/// Create a copy of NormalizedPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NormalizedPointCopyWith<NormalizedPoint> get copyWith => _$NormalizedPointCopyWithImpl<NormalizedPoint>(this as NormalizedPoint, _$identity);

  /// Serializes this NormalizedPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NormalizedPoint&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y);

@override
String toString() {
  return 'NormalizedPoint(x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class $NormalizedPointCopyWith<$Res>  {
  factory $NormalizedPointCopyWith(NormalizedPoint value, $Res Function(NormalizedPoint) _then) = _$NormalizedPointCopyWithImpl;
@useResult
$Res call({
 double x, double y
});




}
/// @nodoc
class _$NormalizedPointCopyWithImpl<$Res>
    implements $NormalizedPointCopyWith<$Res> {
  _$NormalizedPointCopyWithImpl(this._self, this._then);

  final NormalizedPoint _self;
  final $Res Function(NormalizedPoint) _then;

/// Create a copy of NormalizedPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? x = null,Object? y = null,}) {
  return _then(_self.copyWith(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _NormalizedPoint implements NormalizedPoint {
  const _NormalizedPoint({this.x = 0.0, this.y = 0.0});
  factory _NormalizedPoint.fromJson(Map<String, dynamic> json) => _$NormalizedPointFromJson(json);

@override@JsonKey() final  double x;
@override@JsonKey() final  double y;

/// Create a copy of NormalizedPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NormalizedPointCopyWith<_NormalizedPoint> get copyWith => __$NormalizedPointCopyWithImpl<_NormalizedPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NormalizedPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NormalizedPoint&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y);

@override
String toString() {
  return 'NormalizedPoint(x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class _$NormalizedPointCopyWith<$Res> implements $NormalizedPointCopyWith<$Res> {
  factory _$NormalizedPointCopyWith(_NormalizedPoint value, $Res Function(_NormalizedPoint) _then) = __$NormalizedPointCopyWithImpl;
@override @useResult
$Res call({
 double x, double y
});




}
/// @nodoc
class __$NormalizedPointCopyWithImpl<$Res>
    implements _$NormalizedPointCopyWith<$Res> {
  __$NormalizedPointCopyWithImpl(this._self, this._then);

  final _NormalizedPoint _self;
  final $Res Function(_NormalizedPoint) _then;

/// Create a copy of NormalizedPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? x = null,Object? y = null,}) {
  return _then(_NormalizedPoint(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
