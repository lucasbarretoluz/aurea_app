import 'package:freezed_annotation/freezed_annotation.dart';
import 'patient_model.dart';

part 'patient_paginated_response.g.dart';
part 'patient_paginated_response.freezed.dart';

@freezed
abstract class PatientPaginatedResponse with _$PatientPaginatedResponse {
  const factory PatientPaginatedResponse({
    @Default(0) int limit,
    @Default(0) int page,
    @Default([]) List<PatientModel> patients,
    @Default(0) int total,
    @Default(0) int totalPages,
  }) = _PatientPaginatedResponse;

  factory PatientPaginatedResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientPaginatedResponseFromJson(json);
}
