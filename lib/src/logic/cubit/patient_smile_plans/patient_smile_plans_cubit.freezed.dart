// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_smile_plans_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PatientSmilePlansState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatientSmilePlansState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PatientSmilePlansState()';
}


}

/// @nodoc
class $PatientSmilePlansStateCopyWith<$Res>  {
$PatientSmilePlansStateCopyWith(PatientSmilePlansState _, $Res Function(PatientSmilePlansState) __);
}


/// @nodoc


class PatientSmilePlansInitial implements PatientSmilePlansState {
  const PatientSmilePlansInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatientSmilePlansInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PatientSmilePlansState.initial()';
}


}




/// @nodoc


class PatientSmilePlansLoading implements PatientSmilePlansState {
  const PatientSmilePlansLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatientSmilePlansLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PatientSmilePlansState.loading()';
}


}




/// @nodoc


class PatientSmilePlansLoaded implements PatientSmilePlansState {
  const PatientSmilePlansLoaded({required final  List<SmilePlan> plans}): _plans = plans;
  

 final  List<SmilePlan> _plans;
 List<SmilePlan> get plans {
  if (_plans is EqualUnmodifiableListView) return _plans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_plans);
}


/// Create a copy of PatientSmilePlansState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatientSmilePlansLoadedCopyWith<PatientSmilePlansLoaded> get copyWith => _$PatientSmilePlansLoadedCopyWithImpl<PatientSmilePlansLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatientSmilePlansLoaded&&const DeepCollectionEquality().equals(other._plans, _plans));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_plans));

@override
String toString() {
  return 'PatientSmilePlansState.loaded(plans: $plans)';
}


}

/// @nodoc
abstract mixin class $PatientSmilePlansLoadedCopyWith<$Res> implements $PatientSmilePlansStateCopyWith<$Res> {
  factory $PatientSmilePlansLoadedCopyWith(PatientSmilePlansLoaded value, $Res Function(PatientSmilePlansLoaded) _then) = _$PatientSmilePlansLoadedCopyWithImpl;
@useResult
$Res call({
 List<SmilePlan> plans
});




}
/// @nodoc
class _$PatientSmilePlansLoadedCopyWithImpl<$Res>
    implements $PatientSmilePlansLoadedCopyWith<$Res> {
  _$PatientSmilePlansLoadedCopyWithImpl(this._self, this._then);

  final PatientSmilePlansLoaded _self;
  final $Res Function(PatientSmilePlansLoaded) _then;

/// Create a copy of PatientSmilePlansState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? plans = null,}) {
  return _then(PatientSmilePlansLoaded(
plans: null == plans ? _self._plans : plans // ignore: cast_nullable_to_non_nullable
as List<SmilePlan>,
  ));
}


}

/// @nodoc


class PatientSmilePlansError implements PatientSmilePlansState {
  const PatientSmilePlansError({required this.message});
  

 final  String message;

/// Create a copy of PatientSmilePlansState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatientSmilePlansErrorCopyWith<PatientSmilePlansError> get copyWith => _$PatientSmilePlansErrorCopyWithImpl<PatientSmilePlansError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatientSmilePlansError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PatientSmilePlansState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $PatientSmilePlansErrorCopyWith<$Res> implements $PatientSmilePlansStateCopyWith<$Res> {
  factory $PatientSmilePlansErrorCopyWith(PatientSmilePlansError value, $Res Function(PatientSmilePlansError) _then) = _$PatientSmilePlansErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$PatientSmilePlansErrorCopyWithImpl<$Res>
    implements $PatientSmilePlansErrorCopyWith<$Res> {
  _$PatientSmilePlansErrorCopyWithImpl(this._self, this._then);

  final PatientSmilePlansError _self;
  final $Res Function(PatientSmilePlansError) _then;

/// Create a copy of PatientSmilePlansState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(PatientSmilePlansError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
