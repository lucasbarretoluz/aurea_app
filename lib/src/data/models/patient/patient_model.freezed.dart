// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PatientModel {

 int get patientId; int get clinicId; String get name; String? get profilePhotoUrl; String? get description; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of PatientModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatientModelCopyWith<PatientModel> get copyWith => _$PatientModelCopyWithImpl<PatientModel>(this as PatientModel, _$identity);

  /// Serializes this PatientModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatientModel&&(identical(other.patientId, patientId) || other.patientId == patientId)&&(identical(other.clinicId, clinicId) || other.clinicId == clinicId)&&(identical(other.name, name) || other.name == name)&&(identical(other.profilePhotoUrl, profilePhotoUrl) || other.profilePhotoUrl == profilePhotoUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,patientId,clinicId,name,profilePhotoUrl,description,createdAt,updatedAt);

@override
String toString() {
  return 'PatientModel(patientId: $patientId, clinicId: $clinicId, name: $name, profilePhotoUrl: $profilePhotoUrl, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PatientModelCopyWith<$Res>  {
  factory $PatientModelCopyWith(PatientModel value, $Res Function(PatientModel) _then) = _$PatientModelCopyWithImpl;
@useResult
$Res call({
 int patientId, int clinicId, String name, String? profilePhotoUrl, String? description, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$PatientModelCopyWithImpl<$Res>
    implements $PatientModelCopyWith<$Res> {
  _$PatientModelCopyWithImpl(this._self, this._then);

  final PatientModel _self;
  final $Res Function(PatientModel) _then;

/// Create a copy of PatientModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? patientId = null,Object? clinicId = null,Object? name = null,Object? profilePhotoUrl = freezed,Object? description = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
patientId: null == patientId ? _self.patientId : patientId // ignore: cast_nullable_to_non_nullable
as int,clinicId: null == clinicId ? _self.clinicId : clinicId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,profilePhotoUrl: freezed == profilePhotoUrl ? _self.profilePhotoUrl : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PatientModel implements PatientModel {
  const _PatientModel({this.patientId = 0, this.clinicId = 0, this.name = '', this.profilePhotoUrl, this.description, required this.createdAt, required this.updatedAt});
  factory _PatientModel.fromJson(Map<String, dynamic> json) => _$PatientModelFromJson(json);

@override@JsonKey() final  int patientId;
@override@JsonKey() final  int clinicId;
@override@JsonKey() final  String name;
@override final  String? profilePhotoUrl;
@override final  String? description;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of PatientModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatientModelCopyWith<_PatientModel> get copyWith => __$PatientModelCopyWithImpl<_PatientModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PatientModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatientModel&&(identical(other.patientId, patientId) || other.patientId == patientId)&&(identical(other.clinicId, clinicId) || other.clinicId == clinicId)&&(identical(other.name, name) || other.name == name)&&(identical(other.profilePhotoUrl, profilePhotoUrl) || other.profilePhotoUrl == profilePhotoUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,patientId,clinicId,name,profilePhotoUrl,description,createdAt,updatedAt);

@override
String toString() {
  return 'PatientModel(patientId: $patientId, clinicId: $clinicId, name: $name, profilePhotoUrl: $profilePhotoUrl, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PatientModelCopyWith<$Res> implements $PatientModelCopyWith<$Res> {
  factory _$PatientModelCopyWith(_PatientModel value, $Res Function(_PatientModel) _then) = __$PatientModelCopyWithImpl;
@override @useResult
$Res call({
 int patientId, int clinicId, String name, String? profilePhotoUrl, String? description, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$PatientModelCopyWithImpl<$Res>
    implements _$PatientModelCopyWith<$Res> {
  __$PatientModelCopyWithImpl(this._self, this._then);

  final _PatientModel _self;
  final $Res Function(_PatientModel) _then;

/// Create a copy of PatientModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? patientId = null,Object? clinicId = null,Object? name = null,Object? profilePhotoUrl = freezed,Object? description = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_PatientModel(
patientId: null == patientId ? _self.patientId : patientId // ignore: cast_nullable_to_non_nullable
as int,clinicId: null == clinicId ? _self.clinicId : clinicId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,profilePhotoUrl: freezed == profilePhotoUrl ? _self.profilePhotoUrl : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
