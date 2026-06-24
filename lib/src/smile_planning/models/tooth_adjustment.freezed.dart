// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tooth_adjustment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ToothAdjustment {

 int get toothIndex; LineTransform get transform;
/// Create a copy of ToothAdjustment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToothAdjustmentCopyWith<ToothAdjustment> get copyWith => _$ToothAdjustmentCopyWithImpl<ToothAdjustment>(this as ToothAdjustment, _$identity);

  /// Serializes this ToothAdjustment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToothAdjustment&&(identical(other.toothIndex, toothIndex) || other.toothIndex == toothIndex)&&(identical(other.transform, transform) || other.transform == transform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,toothIndex,transform);

@override
String toString() {
  return 'ToothAdjustment(toothIndex: $toothIndex, transform: $transform)';
}


}

/// @nodoc
abstract mixin class $ToothAdjustmentCopyWith<$Res>  {
  factory $ToothAdjustmentCopyWith(ToothAdjustment value, $Res Function(ToothAdjustment) _then) = _$ToothAdjustmentCopyWithImpl;
@useResult
$Res call({
 int toothIndex, LineTransform transform
});


$LineTransformCopyWith<$Res> get transform;

}
/// @nodoc
class _$ToothAdjustmentCopyWithImpl<$Res>
    implements $ToothAdjustmentCopyWith<$Res> {
  _$ToothAdjustmentCopyWithImpl(this._self, this._then);

  final ToothAdjustment _self;
  final $Res Function(ToothAdjustment) _then;

/// Create a copy of ToothAdjustment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? toothIndex = null,Object? transform = null,}) {
  return _then(_self.copyWith(
toothIndex: null == toothIndex ? _self.toothIndex : toothIndex // ignore: cast_nullable_to_non_nullable
as int,transform: null == transform ? _self.transform : transform // ignore: cast_nullable_to_non_nullable
as LineTransform,
  ));
}
/// Create a copy of ToothAdjustment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LineTransformCopyWith<$Res> get transform {
  
  return $LineTransformCopyWith<$Res>(_self.transform, (value) {
    return _then(_self.copyWith(transform: value));
  });
}
}


/// @nodoc

@JsonSerializable(explicitToJson: true)
class _ToothAdjustment implements ToothAdjustment {
  const _ToothAdjustment({this.toothIndex = 0, this.transform = const LineTransform()});
  factory _ToothAdjustment.fromJson(Map<String, dynamic> json) => _$ToothAdjustmentFromJson(json);

@override@JsonKey() final  int toothIndex;
@override@JsonKey() final  LineTransform transform;

/// Create a copy of ToothAdjustment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToothAdjustmentCopyWith<_ToothAdjustment> get copyWith => __$ToothAdjustmentCopyWithImpl<_ToothAdjustment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToothAdjustmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToothAdjustment&&(identical(other.toothIndex, toothIndex) || other.toothIndex == toothIndex)&&(identical(other.transform, transform) || other.transform == transform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,toothIndex,transform);

@override
String toString() {
  return 'ToothAdjustment(toothIndex: $toothIndex, transform: $transform)';
}


}

/// @nodoc
abstract mixin class _$ToothAdjustmentCopyWith<$Res> implements $ToothAdjustmentCopyWith<$Res> {
  factory _$ToothAdjustmentCopyWith(_ToothAdjustment value, $Res Function(_ToothAdjustment) _then) = __$ToothAdjustmentCopyWithImpl;
@override @useResult
$Res call({
 int toothIndex, LineTransform transform
});


@override $LineTransformCopyWith<$Res> get transform;

}
/// @nodoc
class __$ToothAdjustmentCopyWithImpl<$Res>
    implements _$ToothAdjustmentCopyWith<$Res> {
  __$ToothAdjustmentCopyWithImpl(this._self, this._then);

  final _ToothAdjustment _self;
  final $Res Function(_ToothAdjustment) _then;

/// Create a copy of ToothAdjustment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? toothIndex = null,Object? transform = null,}) {
  return _then(_ToothAdjustment(
toothIndex: null == toothIndex ? _self.toothIndex : toothIndex // ignore: cast_nullable_to_non_nullable
as int,transform: null == transform ? _self.transform : transform // ignore: cast_nullable_to_non_nullable
as LineTransform,
  ));
}

/// Create a copy of ToothAdjustment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LineTransformCopyWith<$Res> get transform {
  
  return $LineTransformCopyWith<$Res>(_self.transform, (value) {
    return _then(_self.copyWith(transform: value));
  });
}
}

// dart format on
