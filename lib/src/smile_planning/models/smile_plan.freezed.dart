// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'smile_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SmilePlan {

 String get id; int get patientId; String get photoUrl; ReferenceLines get referenceLines; ImageTransform? get imageTransform; CurveData? get curve; ToothShape get toothShape; List<ToothAdjustment> get toothAdjustments; String? get veneerStyleId; SmilePlanningStep get currentStep; SmilePlanSyncStatus get syncStatus; DateTime get createdAt; DateTime get updatedAt; DateTime? get completedAt;
/// Create a copy of SmilePlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SmilePlanCopyWith<SmilePlan> get copyWith => _$SmilePlanCopyWithImpl<SmilePlan>(this as SmilePlan, _$identity);

  /// Serializes this SmilePlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmilePlan&&(identical(other.id, id) || other.id == id)&&(identical(other.patientId, patientId) || other.patientId == patientId)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.referenceLines, referenceLines) || other.referenceLines == referenceLines)&&(identical(other.imageTransform, imageTransform) || other.imageTransform == imageTransform)&&(identical(other.curve, curve) || other.curve == curve)&&(identical(other.toothShape, toothShape) || other.toothShape == toothShape)&&const DeepCollectionEquality().equals(other.toothAdjustments, toothAdjustments)&&(identical(other.veneerStyleId, veneerStyleId) || other.veneerStyleId == veneerStyleId)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,patientId,photoUrl,referenceLines,imageTransform,curve,toothShape,const DeepCollectionEquality().hash(toothAdjustments),veneerStyleId,currentStep,syncStatus,createdAt,updatedAt,completedAt);

@override
String toString() {
  return 'SmilePlan(id: $id, patientId: $patientId, photoUrl: $photoUrl, referenceLines: $referenceLines, imageTransform: $imageTransform, curve: $curve, toothShape: $toothShape, toothAdjustments: $toothAdjustments, veneerStyleId: $veneerStyleId, currentStep: $currentStep, syncStatus: $syncStatus, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $SmilePlanCopyWith<$Res>  {
  factory $SmilePlanCopyWith(SmilePlan value, $Res Function(SmilePlan) _then) = _$SmilePlanCopyWithImpl;
@useResult
$Res call({
 String id, int patientId, String photoUrl, ReferenceLines referenceLines, ImageTransform? imageTransform, CurveData? curve, ToothShape toothShape, List<ToothAdjustment> toothAdjustments, String? veneerStyleId, SmilePlanningStep currentStep, SmilePlanSyncStatus syncStatus, DateTime createdAt, DateTime updatedAt, DateTime? completedAt
});


$ReferenceLinesCopyWith<$Res> get referenceLines;$ImageTransformCopyWith<$Res>? get imageTransform;$CurveDataCopyWith<$Res>? get curve;

}
/// @nodoc
class _$SmilePlanCopyWithImpl<$Res>
    implements $SmilePlanCopyWith<$Res> {
  _$SmilePlanCopyWithImpl(this._self, this._then);

  final SmilePlan _self;
  final $Res Function(SmilePlan) _then;

/// Create a copy of SmilePlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? patientId = null,Object? photoUrl = null,Object? referenceLines = null,Object? imageTransform = freezed,Object? curve = freezed,Object? toothShape = null,Object? toothAdjustments = null,Object? veneerStyleId = freezed,Object? currentStep = null,Object? syncStatus = null,Object? createdAt = null,Object? updatedAt = null,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,patientId: null == patientId ? _self.patientId : patientId // ignore: cast_nullable_to_non_nullable
as int,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,referenceLines: null == referenceLines ? _self.referenceLines : referenceLines // ignore: cast_nullable_to_non_nullable
as ReferenceLines,imageTransform: freezed == imageTransform ? _self.imageTransform : imageTransform // ignore: cast_nullable_to_non_nullable
as ImageTransform?,curve: freezed == curve ? _self.curve : curve // ignore: cast_nullable_to_non_nullable
as CurveData?,toothShape: null == toothShape ? _self.toothShape : toothShape // ignore: cast_nullable_to_non_nullable
as ToothShape,toothAdjustments: null == toothAdjustments ? _self.toothAdjustments : toothAdjustments // ignore: cast_nullable_to_non_nullable
as List<ToothAdjustment>,veneerStyleId: freezed == veneerStyleId ? _self.veneerStyleId : veneerStyleId // ignore: cast_nullable_to_non_nullable
as String?,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as SmilePlanningStep,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SmilePlanSyncStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of SmilePlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReferenceLinesCopyWith<$Res> get referenceLines {
  
  return $ReferenceLinesCopyWith<$Res>(_self.referenceLines, (value) {
    return _then(_self.copyWith(referenceLines: value));
  });
}/// Create a copy of SmilePlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImageTransformCopyWith<$Res>? get imageTransform {
    if (_self.imageTransform == null) {
    return null;
  }

  return $ImageTransformCopyWith<$Res>(_self.imageTransform!, (value) {
    return _then(_self.copyWith(imageTransform: value));
  });
}/// Create a copy of SmilePlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurveDataCopyWith<$Res>? get curve {
    if (_self.curve == null) {
    return null;
  }

  return $CurveDataCopyWith<$Res>(_self.curve!, (value) {
    return _then(_self.copyWith(curve: value));
  });
}
}


/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SmilePlan implements SmilePlan {
  const _SmilePlan({required this.id, required this.patientId, this.photoUrl = '', this.referenceLines = const ReferenceLines(), this.imageTransform, this.curve, this.toothShape = ToothShape.oval, final  List<ToothAdjustment> toothAdjustments = const [], this.veneerStyleId, this.currentStep = SmilePlanningStep.faceCenter, this.syncStatus = SmilePlanSyncStatus.localOnly, required this.createdAt, required this.updatedAt, this.completedAt}): _toothAdjustments = toothAdjustments;
  factory _SmilePlan.fromJson(Map<String, dynamic> json) => _$SmilePlanFromJson(json);

@override final  String id;
@override final  int patientId;
@override@JsonKey() final  String photoUrl;
@override@JsonKey() final  ReferenceLines referenceLines;
@override final  ImageTransform? imageTransform;
@override final  CurveData? curve;
@override@JsonKey() final  ToothShape toothShape;
 final  List<ToothAdjustment> _toothAdjustments;
@override@JsonKey() List<ToothAdjustment> get toothAdjustments {
  if (_toothAdjustments is EqualUnmodifiableListView) return _toothAdjustments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_toothAdjustments);
}

@override final  String? veneerStyleId;
@override@JsonKey() final  SmilePlanningStep currentStep;
@override@JsonKey() final  SmilePlanSyncStatus syncStatus;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime? completedAt;

/// Create a copy of SmilePlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SmilePlanCopyWith<_SmilePlan> get copyWith => __$SmilePlanCopyWithImpl<_SmilePlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SmilePlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SmilePlan&&(identical(other.id, id) || other.id == id)&&(identical(other.patientId, patientId) || other.patientId == patientId)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.referenceLines, referenceLines) || other.referenceLines == referenceLines)&&(identical(other.imageTransform, imageTransform) || other.imageTransform == imageTransform)&&(identical(other.curve, curve) || other.curve == curve)&&(identical(other.toothShape, toothShape) || other.toothShape == toothShape)&&const DeepCollectionEquality().equals(other._toothAdjustments, _toothAdjustments)&&(identical(other.veneerStyleId, veneerStyleId) || other.veneerStyleId == veneerStyleId)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,patientId,photoUrl,referenceLines,imageTransform,curve,toothShape,const DeepCollectionEquality().hash(_toothAdjustments),veneerStyleId,currentStep,syncStatus,createdAt,updatedAt,completedAt);

@override
String toString() {
  return 'SmilePlan(id: $id, patientId: $patientId, photoUrl: $photoUrl, referenceLines: $referenceLines, imageTransform: $imageTransform, curve: $curve, toothShape: $toothShape, toothAdjustments: $toothAdjustments, veneerStyleId: $veneerStyleId, currentStep: $currentStep, syncStatus: $syncStatus, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$SmilePlanCopyWith<$Res> implements $SmilePlanCopyWith<$Res> {
  factory _$SmilePlanCopyWith(_SmilePlan value, $Res Function(_SmilePlan) _then) = __$SmilePlanCopyWithImpl;
@override @useResult
$Res call({
 String id, int patientId, String photoUrl, ReferenceLines referenceLines, ImageTransform? imageTransform, CurveData? curve, ToothShape toothShape, List<ToothAdjustment> toothAdjustments, String? veneerStyleId, SmilePlanningStep currentStep, SmilePlanSyncStatus syncStatus, DateTime createdAt, DateTime updatedAt, DateTime? completedAt
});


@override $ReferenceLinesCopyWith<$Res> get referenceLines;@override $ImageTransformCopyWith<$Res>? get imageTransform;@override $CurveDataCopyWith<$Res>? get curve;

}
/// @nodoc
class __$SmilePlanCopyWithImpl<$Res>
    implements _$SmilePlanCopyWith<$Res> {
  __$SmilePlanCopyWithImpl(this._self, this._then);

  final _SmilePlan _self;
  final $Res Function(_SmilePlan) _then;

/// Create a copy of SmilePlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? patientId = null,Object? photoUrl = null,Object? referenceLines = null,Object? imageTransform = freezed,Object? curve = freezed,Object? toothShape = null,Object? toothAdjustments = null,Object? veneerStyleId = freezed,Object? currentStep = null,Object? syncStatus = null,Object? createdAt = null,Object? updatedAt = null,Object? completedAt = freezed,}) {
  return _then(_SmilePlan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,patientId: null == patientId ? _self.patientId : patientId // ignore: cast_nullable_to_non_nullable
as int,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,referenceLines: null == referenceLines ? _self.referenceLines : referenceLines // ignore: cast_nullable_to_non_nullable
as ReferenceLines,imageTransform: freezed == imageTransform ? _self.imageTransform : imageTransform // ignore: cast_nullable_to_non_nullable
as ImageTransform?,curve: freezed == curve ? _self.curve : curve // ignore: cast_nullable_to_non_nullable
as CurveData?,toothShape: null == toothShape ? _self.toothShape : toothShape // ignore: cast_nullable_to_non_nullable
as ToothShape,toothAdjustments: null == toothAdjustments ? _self._toothAdjustments : toothAdjustments // ignore: cast_nullable_to_non_nullable
as List<ToothAdjustment>,veneerStyleId: freezed == veneerStyleId ? _self.veneerStyleId : veneerStyleId // ignore: cast_nullable_to_non_nullable
as String?,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as SmilePlanningStep,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SmilePlanSyncStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of SmilePlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReferenceLinesCopyWith<$Res> get referenceLines {
  
  return $ReferenceLinesCopyWith<$Res>(_self.referenceLines, (value) {
    return _then(_self.copyWith(referenceLines: value));
  });
}/// Create a copy of SmilePlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImageTransformCopyWith<$Res>? get imageTransform {
    if (_self.imageTransform == null) {
    return null;
  }

  return $ImageTransformCopyWith<$Res>(_self.imageTransform!, (value) {
    return _then(_self.copyWith(imageTransform: value));
  });
}/// Create a copy of SmilePlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurveDataCopyWith<$Res>? get curve {
    if (_self.curve == null) {
    return null;
  }

  return $CurveDataCopyWith<$Res>(_self.curve!, (value) {
    return _then(_self.copyWith(curve: value));
  });
}
}

// dart format on
