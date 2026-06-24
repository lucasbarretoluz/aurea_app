// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reference_line.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReferenceLine {

 ReferenceLineType get type; CalibrationPhase get phase; LineTransform get transform;
/// Create a copy of ReferenceLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReferenceLineCopyWith<ReferenceLine> get copyWith => _$ReferenceLineCopyWithImpl<ReferenceLine>(this as ReferenceLine, _$identity);

  /// Serializes this ReferenceLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReferenceLine&&(identical(other.type, type) || other.type == type)&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.transform, transform) || other.transform == transform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,phase,transform);

@override
String toString() {
  return 'ReferenceLine(type: $type, phase: $phase, transform: $transform)';
}


}

/// @nodoc
abstract mixin class $ReferenceLineCopyWith<$Res>  {
  factory $ReferenceLineCopyWith(ReferenceLine value, $Res Function(ReferenceLine) _then) = _$ReferenceLineCopyWithImpl;
@useResult
$Res call({
 ReferenceLineType type, CalibrationPhase phase, LineTransform transform
});


$LineTransformCopyWith<$Res> get transform;

}
/// @nodoc
class _$ReferenceLineCopyWithImpl<$Res>
    implements $ReferenceLineCopyWith<$Res> {
  _$ReferenceLineCopyWithImpl(this._self, this._then);

  final ReferenceLine _self;
  final $Res Function(ReferenceLine) _then;

/// Create a copy of ReferenceLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? phase = null,Object? transform = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReferenceLineType,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CalibrationPhase,transform: null == transform ? _self.transform : transform // ignore: cast_nullable_to_non_nullable
as LineTransform,
  ));
}
/// Create a copy of ReferenceLine
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
class _ReferenceLine implements ReferenceLine {
  const _ReferenceLine({required this.type, required this.phase, this.transform = const LineTransform()});
  factory _ReferenceLine.fromJson(Map<String, dynamic> json) => _$ReferenceLineFromJson(json);

@override final  ReferenceLineType type;
@override final  CalibrationPhase phase;
@override@JsonKey() final  LineTransform transform;

/// Create a copy of ReferenceLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReferenceLineCopyWith<_ReferenceLine> get copyWith => __$ReferenceLineCopyWithImpl<_ReferenceLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReferenceLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReferenceLine&&(identical(other.type, type) || other.type == type)&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.transform, transform) || other.transform == transform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,phase,transform);

@override
String toString() {
  return 'ReferenceLine(type: $type, phase: $phase, transform: $transform)';
}


}

/// @nodoc
abstract mixin class _$ReferenceLineCopyWith<$Res> implements $ReferenceLineCopyWith<$Res> {
  factory _$ReferenceLineCopyWith(_ReferenceLine value, $Res Function(_ReferenceLine) _then) = __$ReferenceLineCopyWithImpl;
@override @useResult
$Res call({
 ReferenceLineType type, CalibrationPhase phase, LineTransform transform
});


@override $LineTransformCopyWith<$Res> get transform;

}
/// @nodoc
class __$ReferenceLineCopyWithImpl<$Res>
    implements _$ReferenceLineCopyWith<$Res> {
  __$ReferenceLineCopyWithImpl(this._self, this._then);

  final _ReferenceLine _self;
  final $Res Function(_ReferenceLine) _then;

/// Create a copy of ReferenceLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? phase = null,Object? transform = null,}) {
  return _then(_ReferenceLine(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReferenceLineType,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CalibrationPhase,transform: null == transform ? _self.transform : transform // ignore: cast_nullable_to_non_nullable
as LineTransform,
  ));
}

/// Create a copy of ReferenceLine
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
