// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_token.g.dart';
part 'auth_token.freezed.dart';

@freezed
abstract class AuthToken with _$AuthToken {
  const factory AuthToken({
    String? accessToken,
    String? refreshToken,
    @Default('') String nameUser,
    @Default('') String email,
    @Default('') String phone,
    @Default(false) bool isPremium,
    String? photo,
  }) = _AuthToken;

  factory AuthToken.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenFromJson(json);
}
