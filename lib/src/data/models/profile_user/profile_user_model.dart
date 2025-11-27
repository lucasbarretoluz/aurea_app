import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_user_model.freezed.dart';
part 'profile_user_model.g.dart';

@freezed
abstract class ProfileUserModel with _$ProfileUserModel {
  const factory ProfileUserModel({
    @Default('') String nameUser,
    @Default('') String email,
    @Default('') String phone,
    @Default(false) bool isPremium,
    String? photo,
    
  }) = _ProfileUserModel;

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileUserModelFromJson(json);
}
