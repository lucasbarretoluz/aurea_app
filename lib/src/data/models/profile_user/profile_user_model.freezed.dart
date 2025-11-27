// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileUserModel {

 String get nameUser; String get email; String get phone; bool get isPremium; String? get photo;
/// Create a copy of ProfileUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileUserModelCopyWith<ProfileUserModel> get copyWith => _$ProfileUserModelCopyWithImpl<ProfileUserModel>(this as ProfileUserModel, _$identity);

  /// Serializes this ProfileUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileUserModel&&(identical(other.nameUser, nameUser) || other.nameUser == nameUser)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.photo, photo) || other.photo == photo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nameUser,email,phone,isPremium,photo);

@override
String toString() {
  return 'ProfileUserModel(nameUser: $nameUser, email: $email, phone: $phone, isPremium: $isPremium, photo: $photo)';
}


}

/// @nodoc
abstract mixin class $ProfileUserModelCopyWith<$Res>  {
  factory $ProfileUserModelCopyWith(ProfileUserModel value, $Res Function(ProfileUserModel) _then) = _$ProfileUserModelCopyWithImpl;
@useResult
$Res call({
 String nameUser, String email, String phone, bool isPremium, String? photo
});




}
/// @nodoc
class _$ProfileUserModelCopyWithImpl<$Res>
    implements $ProfileUserModelCopyWith<$Res> {
  _$ProfileUserModelCopyWithImpl(this._self, this._then);

  final ProfileUserModel _self;
  final $Res Function(ProfileUserModel) _then;

/// Create a copy of ProfileUserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nameUser = null,Object? email = null,Object? phone = null,Object? isPremium = null,Object? photo = freezed,}) {
  return _then(_self.copyWith(
nameUser: null == nameUser ? _self.nameUser : nameUser // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ProfileUserModel implements ProfileUserModel {
  const _ProfileUserModel({this.nameUser = '', this.email = '', this.phone = '', this.isPremium = false, this.photo});
  factory _ProfileUserModel.fromJson(Map<String, dynamic> json) => _$ProfileUserModelFromJson(json);

@override@JsonKey() final  String nameUser;
@override@JsonKey() final  String email;
@override@JsonKey() final  String phone;
@override@JsonKey() final  bool isPremium;
@override final  String? photo;

/// Create a copy of ProfileUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileUserModelCopyWith<_ProfileUserModel> get copyWith => __$ProfileUserModelCopyWithImpl<_ProfileUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileUserModel&&(identical(other.nameUser, nameUser) || other.nameUser == nameUser)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.photo, photo) || other.photo == photo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nameUser,email,phone,isPremium,photo);

@override
String toString() {
  return 'ProfileUserModel(nameUser: $nameUser, email: $email, phone: $phone, isPremium: $isPremium, photo: $photo)';
}


}

/// @nodoc
abstract mixin class _$ProfileUserModelCopyWith<$Res> implements $ProfileUserModelCopyWith<$Res> {
  factory _$ProfileUserModelCopyWith(_ProfileUserModel value, $Res Function(_ProfileUserModel) _then) = __$ProfileUserModelCopyWithImpl;
@override @useResult
$Res call({
 String nameUser, String email, String phone, bool isPremium, String? photo
});




}
/// @nodoc
class __$ProfileUserModelCopyWithImpl<$Res>
    implements _$ProfileUserModelCopyWith<$Res> {
  __$ProfileUserModelCopyWithImpl(this._self, this._then);

  final _ProfileUserModel _self;
  final $Res Function(_ProfileUserModel) _then;

/// Create a copy of ProfileUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameUser = null,Object? email = null,Object? phone = null,Object? isPremium = null,Object? photo = freezed,}) {
  return _then(_ProfileUserModel(
nameUser: null == nameUser ? _self.nameUser : nameUser // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
