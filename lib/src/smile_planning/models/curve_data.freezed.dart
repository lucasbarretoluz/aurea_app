// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'curve_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CurveData {

 List<NormalizedPoint> get controlPoints;
/// Create a copy of CurveData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurveDataCopyWith<CurveData> get copyWith => _$CurveDataCopyWithImpl<CurveData>(this as CurveData, _$identity);

  /// Serializes this CurveData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurveData&&const DeepCollectionEquality().equals(other.controlPoints, controlPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(controlPoints));

@override
String toString() {
  return 'CurveData(controlPoints: $controlPoints)';
}


}

/// @nodoc
abstract mixin class $CurveDataCopyWith<$Res>  {
  factory $CurveDataCopyWith(CurveData value, $Res Function(CurveData) _then) = _$CurveDataCopyWithImpl;
@useResult
$Res call({
 List<NormalizedPoint> controlPoints
});




}
/// @nodoc
class _$CurveDataCopyWithImpl<$Res>
    implements $CurveDataCopyWith<$Res> {
  _$CurveDataCopyWithImpl(this._self, this._then);

  final CurveData _self;
  final $Res Function(CurveData) _then;

/// Create a copy of CurveData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? controlPoints = null,}) {
  return _then(_self.copyWith(
controlPoints: null == controlPoints ? _self.controlPoints : controlPoints // ignore: cast_nullable_to_non_nullable
as List<NormalizedPoint>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CurveData implements CurveData {
  const _CurveData({final  List<NormalizedPoint> controlPoints = const []}): _controlPoints = controlPoints;
  factory _CurveData.fromJson(Map<String, dynamic> json) => _$CurveDataFromJson(json);

 final  List<NormalizedPoint> _controlPoints;
@override@JsonKey() List<NormalizedPoint> get controlPoints {
  if (_controlPoints is EqualUnmodifiableListView) return _controlPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_controlPoints);
}


/// Create a copy of CurveData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurveDataCopyWith<_CurveData> get copyWith => __$CurveDataCopyWithImpl<_CurveData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurveDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurveData&&const DeepCollectionEquality().equals(other._controlPoints, _controlPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_controlPoints));

@override
String toString() {
  return 'CurveData(controlPoints: $controlPoints)';
}


}

/// @nodoc
abstract mixin class _$CurveDataCopyWith<$Res> implements $CurveDataCopyWith<$Res> {
  factory _$CurveDataCopyWith(_CurveData value, $Res Function(_CurveData) _then) = __$CurveDataCopyWithImpl;
@override @useResult
$Res call({
 List<NormalizedPoint> controlPoints
});




}
/// @nodoc
class __$CurveDataCopyWithImpl<$Res>
    implements _$CurveDataCopyWith<$Res> {
  __$CurveDataCopyWithImpl(this._self, this._then);

  final _CurveData _self;
  final $Res Function(_CurveData) _then;

/// Create a copy of CurveData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? controlPoints = null,}) {
  return _then(_CurveData(
controlPoints: null == controlPoints ? _self._controlPoints : controlPoints // ignore: cast_nullable_to_non_nullable
as List<NormalizedPoint>,
  ));
}


}

// dart format on
