// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ClinicState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClinicState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClinicState()';
}


}

/// @nodoc
class $ClinicStateCopyWith<$Res>  {
$ClinicStateCopyWith(ClinicState _, $Res Function(ClinicState) __);
}


/// @nodoc


class _Initial implements ClinicState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClinicState.initial()';
}


}




/// @nodoc


class _Loading implements ClinicState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClinicState.loading()';
}


}




/// @nodoc


class _Loaded implements ClinicState {
  const _Loaded({required final  List<ClinicModel> clinics}): _clinics = clinics;
  

 final  List<ClinicModel> _clinics;
 List<ClinicModel> get clinics {
  if (_clinics is EqualUnmodifiableListView) return _clinics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_clinics);
}


/// Create a copy of ClinicState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._clinics, _clinics));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_clinics));

@override
String toString() {
  return 'ClinicState.loaded(clinics: $clinics)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $ClinicStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<ClinicModel> clinics
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of ClinicState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? clinics = null,}) {
  return _then(_Loaded(
clinics: null == clinics ? _self._clinics : clinics // ignore: cast_nullable_to_non_nullable
as List<ClinicModel>,
  ));
}


}

/// @nodoc


class _ClinicLoaded implements ClinicState {
  const _ClinicLoaded({required this.clinic});
  

 final  ClinicModel clinic;

/// Create a copy of ClinicState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClinicLoadedCopyWith<_ClinicLoaded> get copyWith => __$ClinicLoadedCopyWithImpl<_ClinicLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClinicLoaded&&(identical(other.clinic, clinic) || other.clinic == clinic));
}


@override
int get hashCode => Object.hash(runtimeType,clinic);

@override
String toString() {
  return 'ClinicState.clinicLoaded(clinic: $clinic)';
}


}

/// @nodoc
abstract mixin class _$ClinicLoadedCopyWith<$Res> implements $ClinicStateCopyWith<$Res> {
  factory _$ClinicLoadedCopyWith(_ClinicLoaded value, $Res Function(_ClinicLoaded) _then) = __$ClinicLoadedCopyWithImpl;
@useResult
$Res call({
 ClinicModel clinic
});


$ClinicModelCopyWith<$Res> get clinic;

}
/// @nodoc
class __$ClinicLoadedCopyWithImpl<$Res>
    implements _$ClinicLoadedCopyWith<$Res> {
  __$ClinicLoadedCopyWithImpl(this._self, this._then);

  final _ClinicLoaded _self;
  final $Res Function(_ClinicLoaded) _then;

/// Create a copy of ClinicState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? clinic = null,}) {
  return _then(_ClinicLoaded(
clinic: null == clinic ? _self.clinic : clinic // ignore: cast_nullable_to_non_nullable
as ClinicModel,
  ));
}

/// Create a copy of ClinicState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicModelCopyWith<$Res> get clinic {
  
  return $ClinicModelCopyWith<$Res>(_self.clinic, (value) {
    return _then(_self.copyWith(clinic: value));
  });
}
}

/// @nodoc


class _Error implements ClinicState {
  const _Error({required this.message});
  

 final  String message;

/// Create a copy of ClinicState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ClinicState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $ClinicStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of ClinicState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
