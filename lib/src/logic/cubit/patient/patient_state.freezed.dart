// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PatientState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatientState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PatientState()';
}


}

/// @nodoc
class $PatientStateCopyWith<$Res>  {
$PatientStateCopyWith(PatientState _, $Res Function(PatientState) __);
}


/// @nodoc


class Initial implements PatientState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PatientState.initial()';
}


}




/// @nodoc


class Loading implements PatientState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PatientState.loading()';
}


}




/// @nodoc


class Loaded implements PatientState {
  const Loaded({required final  List<PatientModel> patients, final  List<PatientModel>? filteredPatients, required this.total, required this.page, required this.limit, required this.hasMore}): _patients = patients,_filteredPatients = filteredPatients;
  

 final  List<PatientModel> _patients;
 List<PatientModel> get patients {
  if (_patients is EqualUnmodifiableListView) return _patients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_patients);
}

 final  List<PatientModel>? _filteredPatients;
 List<PatientModel>? get filteredPatients {
  final value = _filteredPatients;
  if (value == null) return null;
  if (_filteredPatients is EqualUnmodifiableListView) return _filteredPatients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  int total;
 final  int page;
 final  int limit;
 final  bool hasMore;

/// Create a copy of PatientState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&const DeepCollectionEquality().equals(other._patients, _patients)&&const DeepCollectionEquality().equals(other._filteredPatients, _filteredPatients)&&(identical(other.total, total) || other.total == total)&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_patients),const DeepCollectionEquality().hash(_filteredPatients),total,page,limit,hasMore);

@override
String toString() {
  return 'PatientState.loaded(patients: $patients, filteredPatients: $filteredPatients, total: $total, page: $page, limit: $limit, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $PatientStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 List<PatientModel> patients, List<PatientModel>? filteredPatients, int total, int page, int limit, bool hasMore
});




}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of PatientState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? patients = null,Object? filteredPatients = freezed,Object? total = null,Object? page = null,Object? limit = null,Object? hasMore = null,}) {
  return _then(Loaded(
patients: null == patients ? _self._patients : patients // ignore: cast_nullable_to_non_nullable
as List<PatientModel>,filteredPatients: freezed == filteredPatients ? _self._filteredPatients : filteredPatients // ignore: cast_nullable_to_non_nullable
as List<PatientModel>?,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class Error implements PatientState {
  const Error(this.message);
  

 final  String message;

/// Create a copy of PatientState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorCopyWith<Error> get copyWith => _$ErrorCopyWithImpl<Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PatientState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $PatientStateCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) _then) = _$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(this._self, this._then);

  final Error _self;
  final $Res Function(Error) _then;

/// Create a copy of PatientState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
