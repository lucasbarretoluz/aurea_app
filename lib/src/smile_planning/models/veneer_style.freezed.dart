// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'veneer_style.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VeneerStyle {

 String get id; String get name; String? get assetPath; String? get url;
/// Create a copy of VeneerStyle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VeneerStyleCopyWith<VeneerStyle> get copyWith => _$VeneerStyleCopyWithImpl<VeneerStyle>(this as VeneerStyle, _$identity);

  /// Serializes this VeneerStyle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VeneerStyle&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.assetPath, assetPath) || other.assetPath == assetPath)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,assetPath,url);

@override
String toString() {
  return 'VeneerStyle(id: $id, name: $name, assetPath: $assetPath, url: $url)';
}


}

/// @nodoc
abstract mixin class $VeneerStyleCopyWith<$Res>  {
  factory $VeneerStyleCopyWith(VeneerStyle value, $Res Function(VeneerStyle) _then) = _$VeneerStyleCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? assetPath, String? url
});




}
/// @nodoc
class _$VeneerStyleCopyWithImpl<$Res>
    implements $VeneerStyleCopyWith<$Res> {
  _$VeneerStyleCopyWithImpl(this._self, this._then);

  final VeneerStyle _self;
  final $Res Function(VeneerStyle) _then;

/// Create a copy of VeneerStyle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? assetPath = freezed,Object? url = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,assetPath: freezed == assetPath ? _self.assetPath : assetPath // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _VeneerStyle implements VeneerStyle {
  const _VeneerStyle({required this.id, required this.name, this.assetPath, this.url});
  factory _VeneerStyle.fromJson(Map<String, dynamic> json) => _$VeneerStyleFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? assetPath;
@override final  String? url;

/// Create a copy of VeneerStyle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VeneerStyleCopyWith<_VeneerStyle> get copyWith => __$VeneerStyleCopyWithImpl<_VeneerStyle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VeneerStyleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VeneerStyle&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.assetPath, assetPath) || other.assetPath == assetPath)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,assetPath,url);

@override
String toString() {
  return 'VeneerStyle(id: $id, name: $name, assetPath: $assetPath, url: $url)';
}


}

/// @nodoc
abstract mixin class _$VeneerStyleCopyWith<$Res> implements $VeneerStyleCopyWith<$Res> {
  factory _$VeneerStyleCopyWith(_VeneerStyle value, $Res Function(_VeneerStyle) _then) = __$VeneerStyleCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? assetPath, String? url
});




}
/// @nodoc
class __$VeneerStyleCopyWithImpl<$Res>
    implements _$VeneerStyleCopyWith<$Res> {
  __$VeneerStyleCopyWithImpl(this._self, this._then);

  final _VeneerStyle _self;
  final $Res Function(_VeneerStyle) _then;

/// Create a copy of VeneerStyle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? assetPath = freezed,Object? url = freezed,}) {
  return _then(_VeneerStyle(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,assetPath: freezed == assetPath ? _self.assetPath : assetPath // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
