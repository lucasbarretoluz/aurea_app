// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'smile_planning_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SmilePlanningState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmilePlanningState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SmilePlanningState()';
}


}

/// @nodoc
class $SmilePlanningStateCopyWith<$Res>  {
$SmilePlanningStateCopyWith(SmilePlanningState _, $Res Function(SmilePlanningState) __);
}


/// @nodoc


class SmilePlanningInitial implements SmilePlanningState {
  const SmilePlanningInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmilePlanningInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SmilePlanningState.initial()';
}


}




/// @nodoc


class SmilePlanningStepActive implements SmilePlanningState {
  const SmilePlanningStepActive({required this.step, required this.plan, required final  List<String> photoUrls, required this.activePhotoUrl}): _photoUrls = photoUrls;
  

 final  SmilePlanningStep step;
 final  SmilePlan plan;
 final  List<String> _photoUrls;
 List<String> get photoUrls {
  if (_photoUrls is EqualUnmodifiableListView) return _photoUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photoUrls);
}

 final  String activePhotoUrl;

/// Create a copy of SmilePlanningState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SmilePlanningStepActiveCopyWith<SmilePlanningStepActive> get copyWith => _$SmilePlanningStepActiveCopyWithImpl<SmilePlanningStepActive>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmilePlanningStepActive&&(identical(other.step, step) || other.step == step)&&(identical(other.plan, plan) || other.plan == plan)&&const DeepCollectionEquality().equals(other._photoUrls, _photoUrls)&&(identical(other.activePhotoUrl, activePhotoUrl) || other.activePhotoUrl == activePhotoUrl));
}


@override
int get hashCode => Object.hash(runtimeType,step,plan,const DeepCollectionEquality().hash(_photoUrls),activePhotoUrl);

@override
String toString() {
  return 'SmilePlanningState.stepActive(step: $step, plan: $plan, photoUrls: $photoUrls, activePhotoUrl: $activePhotoUrl)';
}


}

/// @nodoc
abstract mixin class $SmilePlanningStepActiveCopyWith<$Res> implements $SmilePlanningStateCopyWith<$Res> {
  factory $SmilePlanningStepActiveCopyWith(SmilePlanningStepActive value, $Res Function(SmilePlanningStepActive) _then) = _$SmilePlanningStepActiveCopyWithImpl;
@useResult
$Res call({
 SmilePlanningStep step, SmilePlan plan, List<String> photoUrls, String activePhotoUrl
});


$SmilePlanCopyWith<$Res> get plan;

}
/// @nodoc
class _$SmilePlanningStepActiveCopyWithImpl<$Res>
    implements $SmilePlanningStepActiveCopyWith<$Res> {
  _$SmilePlanningStepActiveCopyWithImpl(this._self, this._then);

  final SmilePlanningStepActive _self;
  final $Res Function(SmilePlanningStepActive) _then;

/// Create a copy of SmilePlanningState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? step = null,Object? plan = null,Object? photoUrls = null,Object? activePhotoUrl = null,}) {
  return _then(SmilePlanningStepActive(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as SmilePlanningStep,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as SmilePlan,photoUrls: null == photoUrls ? _self._photoUrls : photoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,activePhotoUrl: null == activePhotoUrl ? _self.activePhotoUrl : activePhotoUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of SmilePlanningState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SmilePlanCopyWith<$Res> get plan {
  
  return $SmilePlanCopyWith<$Res>(_self.plan, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}

/// @nodoc


class SmilePlanningSaving implements SmilePlanningState {
  const SmilePlanningSaving();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmilePlanningSaving);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SmilePlanningState.saving()';
}


}




/// @nodoc


class SmilePlanningCompleted implements SmilePlanningState {
  const SmilePlanningCompleted({required this.plan});
  

 final  SmilePlan plan;

/// Create a copy of SmilePlanningState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SmilePlanningCompletedCopyWith<SmilePlanningCompleted> get copyWith => _$SmilePlanningCompletedCopyWithImpl<SmilePlanningCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmilePlanningCompleted&&(identical(other.plan, plan) || other.plan == plan));
}


@override
int get hashCode => Object.hash(runtimeType,plan);

@override
String toString() {
  return 'SmilePlanningState.completed(plan: $plan)';
}


}

/// @nodoc
abstract mixin class $SmilePlanningCompletedCopyWith<$Res> implements $SmilePlanningStateCopyWith<$Res> {
  factory $SmilePlanningCompletedCopyWith(SmilePlanningCompleted value, $Res Function(SmilePlanningCompleted) _then) = _$SmilePlanningCompletedCopyWithImpl;
@useResult
$Res call({
 SmilePlan plan
});


$SmilePlanCopyWith<$Res> get plan;

}
/// @nodoc
class _$SmilePlanningCompletedCopyWithImpl<$Res>
    implements $SmilePlanningCompletedCopyWith<$Res> {
  _$SmilePlanningCompletedCopyWithImpl(this._self, this._then);

  final SmilePlanningCompleted _self;
  final $Res Function(SmilePlanningCompleted) _then;

/// Create a copy of SmilePlanningState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? plan = null,}) {
  return _then(SmilePlanningCompleted(
plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as SmilePlan,
  ));
}

/// Create a copy of SmilePlanningState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SmilePlanCopyWith<$Res> get plan {
  
  return $SmilePlanCopyWith<$Res>(_self.plan, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}

/// @nodoc


class SmilePlanningError implements SmilePlanningState {
  const SmilePlanningError({required this.message});
  

 final  String message;

/// Create a copy of SmilePlanningState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SmilePlanningErrorCopyWith<SmilePlanningError> get copyWith => _$SmilePlanningErrorCopyWithImpl<SmilePlanningError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmilePlanningError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SmilePlanningState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $SmilePlanningErrorCopyWith<$Res> implements $SmilePlanningStateCopyWith<$Res> {
  factory $SmilePlanningErrorCopyWith(SmilePlanningError value, $Res Function(SmilePlanningError) _then) = _$SmilePlanningErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SmilePlanningErrorCopyWithImpl<$Res>
    implements $SmilePlanningErrorCopyWith<$Res> {
  _$SmilePlanningErrorCopyWithImpl(this._self, this._then);

  final SmilePlanningError _self;
  final $Res Function(SmilePlanningError) _then;

/// Create a copy of SmilePlanningState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SmilePlanningError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
