// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_photo_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PatientPhotoState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatientPhotoState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PatientPhotoState()';
}


}

/// @nodoc
class $PatientPhotoStateCopyWith<$Res>  {
$PatientPhotoStateCopyWith(PatientPhotoState _, $Res Function(PatientPhotoState) __);
}


/// @nodoc


class Initial implements PatientPhotoState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PatientPhotoState.initial()';
}


}




/// @nodoc


class Loading implements PatientPhotoState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PatientPhotoState.loading()';
}


}




/// @nodoc


class Uploading implements PatientPhotoState {
  const Uploading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Uploading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PatientPhotoState.uploading()';
}


}




/// @nodoc


class Loaded implements PatientPhotoState {
  const Loaded({required final  List<String> urls}): _urls = urls;
  

 final  List<String> _urls;
 List<String> get urls {
  if (_urls is EqualUnmodifiableListView) return _urls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_urls);
}


/// Create a copy of PatientPhotoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&const DeepCollectionEquality().equals(other._urls, _urls));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_urls));

@override
String toString() {
  return 'PatientPhotoState.loaded(urls: $urls)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $PatientPhotoStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 List<String> urls
});




}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of PatientPhotoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? urls = null,}) {
  return _then(Loaded(
urls: null == urls ? _self._urls : urls // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class UploadSuccess implements PatientPhotoState {
  const UploadSuccess({required this.patientId, required this.clinicId, required this.patientName, required final  List<String> photoUrls}): _photoUrls = photoUrls;
  

 final  int patientId;
 final  int clinicId;
 final  String patientName;
 final  List<String> _photoUrls;
 List<String> get photoUrls {
  if (_photoUrls is EqualUnmodifiableListView) return _photoUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photoUrls);
}


/// Create a copy of PatientPhotoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadSuccessCopyWith<UploadSuccess> get copyWith => _$UploadSuccessCopyWithImpl<UploadSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadSuccess&&(identical(other.patientId, patientId) || other.patientId == patientId)&&(identical(other.clinicId, clinicId) || other.clinicId == clinicId)&&(identical(other.patientName, patientName) || other.patientName == patientName)&&const DeepCollectionEquality().equals(other._photoUrls, _photoUrls));
}


@override
int get hashCode => Object.hash(runtimeType,patientId,clinicId,patientName,const DeepCollectionEquality().hash(_photoUrls));

@override
String toString() {
  return 'PatientPhotoState.uploadSuccess(patientId: $patientId, clinicId: $clinicId, patientName: $patientName, photoUrls: $photoUrls)';
}


}

/// @nodoc
abstract mixin class $UploadSuccessCopyWith<$Res> implements $PatientPhotoStateCopyWith<$Res> {
  factory $UploadSuccessCopyWith(UploadSuccess value, $Res Function(UploadSuccess) _then) = _$UploadSuccessCopyWithImpl;
@useResult
$Res call({
 int patientId, int clinicId, String patientName, List<String> photoUrls
});




}
/// @nodoc
class _$UploadSuccessCopyWithImpl<$Res>
    implements $UploadSuccessCopyWith<$Res> {
  _$UploadSuccessCopyWithImpl(this._self, this._then);

  final UploadSuccess _self;
  final $Res Function(UploadSuccess) _then;

/// Create a copy of PatientPhotoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? patientId = null,Object? clinicId = null,Object? patientName = null,Object? photoUrls = null,}) {
  return _then(UploadSuccess(
patientId: null == patientId ? _self.patientId : patientId // ignore: cast_nullable_to_non_nullable
as int,clinicId: null == clinicId ? _self.clinicId : clinicId // ignore: cast_nullable_to_non_nullable
as int,patientName: null == patientName ? _self.patientName : patientName // ignore: cast_nullable_to_non_nullable
as String,photoUrls: null == photoUrls ? _self._photoUrls : photoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class Error implements PatientPhotoState {
  const Error({required this.message});
  

 final  String message;

/// Create a copy of PatientPhotoState
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
  return 'PatientPhotoState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $PatientPhotoStateCopyWith<$Res> {
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

/// Create a copy of PatientPhotoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
