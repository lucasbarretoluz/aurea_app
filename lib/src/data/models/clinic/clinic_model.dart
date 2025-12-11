import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_model.freezed.dart';
part 'clinic_model.g.dart';


@freezed
abstract class ClinicModel with _$ClinicModel {
  const factory ClinicModel({
    @Default(0) int clinicId,
    @Default(0) int userId,
    @Default('') String name,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ClinicModel;

  factory ClinicModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicModelFromJson(json);
}

