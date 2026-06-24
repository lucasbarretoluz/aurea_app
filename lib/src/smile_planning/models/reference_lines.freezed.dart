// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reference_lines.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReferenceLines {

 List<ReferenceLine> get faceLines; List<ReferenceLine> get smileLines;
/// Create a copy of ReferenceLines
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReferenceLinesCopyWith<ReferenceLines> get copyWith => _$ReferenceLinesCopyWithImpl<ReferenceLines>(this as ReferenceLines, _$identity);

  /// Serializes this ReferenceLines to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReferenceLines&&const DeepCollectionEquality().equals(other.faceLines, faceLines)&&const DeepCollectionEquality().equals(other.smileLines, smileLines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(faceLines),const DeepCollectionEquality().hash(smileLines));

@override
String toString() {
  return 'ReferenceLines(faceLines: $faceLines, smileLines: $smileLines)';
}


}

/// @nodoc
abstract mixin class $ReferenceLinesCopyWith<$Res>  {
  factory $ReferenceLinesCopyWith(ReferenceLines value, $Res Function(ReferenceLines) _then) = _$ReferenceLinesCopyWithImpl;
@useResult
$Res call({
 List<ReferenceLine> faceLines, List<ReferenceLine> smileLines
});




}
/// @nodoc
class _$ReferenceLinesCopyWithImpl<$Res>
    implements $ReferenceLinesCopyWith<$Res> {
  _$ReferenceLinesCopyWithImpl(this._self, this._then);

  final ReferenceLines _self;
  final $Res Function(ReferenceLines) _then;

/// Create a copy of ReferenceLines
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? faceLines = null,Object? smileLines = null,}) {
  return _then(_self.copyWith(
faceLines: null == faceLines ? _self.faceLines : faceLines // ignore: cast_nullable_to_non_nullable
as List<ReferenceLine>,smileLines: null == smileLines ? _self.smileLines : smileLines // ignore: cast_nullable_to_non_nullable
as List<ReferenceLine>,
  ));
}

}


/// @nodoc

@JsonSerializable(explicitToJson: true)
class _ReferenceLines implements ReferenceLines {
  const _ReferenceLines({final  List<ReferenceLine> faceLines = const [], final  List<ReferenceLine> smileLines = const []}): _faceLines = faceLines,_smileLines = smileLines;
  factory _ReferenceLines.fromJson(Map<String, dynamic> json) => _$ReferenceLinesFromJson(json);

 final  List<ReferenceLine> _faceLines;
@override@JsonKey() List<ReferenceLine> get faceLines {
  if (_faceLines is EqualUnmodifiableListView) return _faceLines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_faceLines);
}

 final  List<ReferenceLine> _smileLines;
@override@JsonKey() List<ReferenceLine> get smileLines {
  if (_smileLines is EqualUnmodifiableListView) return _smileLines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_smileLines);
}


/// Create a copy of ReferenceLines
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReferenceLinesCopyWith<_ReferenceLines> get copyWith => __$ReferenceLinesCopyWithImpl<_ReferenceLines>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReferenceLinesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReferenceLines&&const DeepCollectionEquality().equals(other._faceLines, _faceLines)&&const DeepCollectionEquality().equals(other._smileLines, _smileLines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_faceLines),const DeepCollectionEquality().hash(_smileLines));

@override
String toString() {
  return 'ReferenceLines(faceLines: $faceLines, smileLines: $smileLines)';
}


}

/// @nodoc
abstract mixin class _$ReferenceLinesCopyWith<$Res> implements $ReferenceLinesCopyWith<$Res> {
  factory _$ReferenceLinesCopyWith(_ReferenceLines value, $Res Function(_ReferenceLines) _then) = __$ReferenceLinesCopyWithImpl;
@override @useResult
$Res call({
 List<ReferenceLine> faceLines, List<ReferenceLine> smileLines
});




}
/// @nodoc
class __$ReferenceLinesCopyWithImpl<$Res>
    implements _$ReferenceLinesCopyWith<$Res> {
  __$ReferenceLinesCopyWithImpl(this._self, this._then);

  final _ReferenceLines _self;
  final $Res Function(_ReferenceLines) _then;

/// Create a copy of ReferenceLines
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? faceLines = null,Object? smileLines = null,}) {
  return _then(_ReferenceLines(
faceLines: null == faceLines ? _self._faceLines : faceLines // ignore: cast_nullable_to_non_nullable
as List<ReferenceLine>,smileLines: null == smileLines ? _self._smileLines : smileLines // ignore: cast_nullable_to_non_nullable
as List<ReferenceLine>,
  ));
}


}

// dart format on
