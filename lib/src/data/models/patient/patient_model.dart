import 'package:aurea_app/src/core/enums/gender_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_model.freezed.dart';
part 'patient_model.g.dart';


@freezed
abstract class PatientModel with _$PatientModel {
  const factory PatientModel({
    @Default(0) int patientId,
    @Default(0) int clinicId,
    @Default('') String name,
    @Default('') String clinicName,
    String? profilePhotoUrl,
    String? description,
    GenderEnum? gender,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PatientModel;

  factory PatientModel.fromJson(Map<String, dynamic> json) =>
      _$PatientModelFromJson(json);
}

