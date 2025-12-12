// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_paginated_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PatientPaginatedResponse {

 int get limit; int get page; List<PatientModel> get patients; int get total; int get totalPages;
/// Create a copy of PatientPaginatedResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatientPaginatedResponseCopyWith<PatientPaginatedResponse> get copyWith => _$PatientPaginatedResponseCopyWithImpl<PatientPaginatedResponse>(this as PatientPaginatedResponse, _$identity);

  /// Serializes this PatientPaginatedResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatientPaginatedResponse&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.page, page) || other.page == page)&&const DeepCollectionEquality().equals(other.patients, patients)&&(identical(other.total, total) || other.total == total)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,limit,page,const DeepCollectionEquality().hash(patients),total,totalPages);

@override
String toString() {
  return 'PatientPaginatedResponse(limit: $limit, page: $page, patients: $patients, total: $total, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class $PatientPaginatedResponseCopyWith<$Res>  {
  factory $PatientPaginatedResponseCopyWith(PatientPaginatedResponse value, $Res Function(PatientPaginatedResponse) _then) = _$PatientPaginatedResponseCopyWithImpl;
@useResult
$Res call({
 int limit, int page, List<PatientModel> patients, int total, int totalPages
});




}
/// @nodoc
class _$PatientPaginatedResponseCopyWithImpl<$Res>
    implements $PatientPaginatedResponseCopyWith<$Res> {
  _$PatientPaginatedResponseCopyWithImpl(this._self, this._then);

  final PatientPaginatedResponse _self;
  final $Res Function(PatientPaginatedResponse) _then;

/// Create a copy of PatientPaginatedResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? limit = null,Object? page = null,Object? patients = null,Object? total = null,Object? totalPages = null,}) {
  return _then(_self.copyWith(
limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,patients: null == patients ? _self.patients : patients // ignore: cast_nullable_to_non_nullable
as List<PatientModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PatientPaginatedResponse implements PatientPaginatedResponse {
  const _PatientPaginatedResponse({this.limit = 0, this.page = 0, final  List<PatientModel> patients = const [], this.total = 0, this.totalPages = 0}): _patients = patients;
  factory _PatientPaginatedResponse.fromJson(Map<String, dynamic> json) => _$PatientPaginatedResponseFromJson(json);

@override@JsonKey() final  int limit;
@override@JsonKey() final  int page;
 final  List<PatientModel> _patients;
@override@JsonKey() List<PatientModel> get patients {
  if (_patients is EqualUnmodifiableListView) return _patients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_patients);
}

@override@JsonKey() final  int total;
@override@JsonKey() final  int totalPages;

/// Create a copy of PatientPaginatedResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatientPaginatedResponseCopyWith<_PatientPaginatedResponse> get copyWith => __$PatientPaginatedResponseCopyWithImpl<_PatientPaginatedResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PatientPaginatedResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatientPaginatedResponse&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.page, page) || other.page == page)&&const DeepCollectionEquality().equals(other._patients, _patients)&&(identical(other.total, total) || other.total == total)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,limit,page,const DeepCollectionEquality().hash(_patients),total,totalPages);

@override
String toString() {
  return 'PatientPaginatedResponse(limit: $limit, page: $page, patients: $patients, total: $total, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class _$PatientPaginatedResponseCopyWith<$Res> implements $PatientPaginatedResponseCopyWith<$Res> {
  factory _$PatientPaginatedResponseCopyWith(_PatientPaginatedResponse value, $Res Function(_PatientPaginatedResponse) _then) = __$PatientPaginatedResponseCopyWithImpl;
@override @useResult
$Res call({
 int limit, int page, List<PatientModel> patients, int total, int totalPages
});




}
/// @nodoc
class __$PatientPaginatedResponseCopyWithImpl<$Res>
    implements _$PatientPaginatedResponseCopyWith<$Res> {
  __$PatientPaginatedResponseCopyWithImpl(this._self, this._then);

  final _PatientPaginatedResponse _self;
  final $Res Function(_PatientPaginatedResponse) _then;

/// Create a copy of PatientPaginatedResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? limit = null,Object? page = null,Object? patients = null,Object? total = null,Object? totalPages = null,}) {
  return _then(_PatientPaginatedResponse(
limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,patients: null == patients ? _self._patients : patients // ignore: cast_nullable_to_non_nullable
as List<PatientModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
