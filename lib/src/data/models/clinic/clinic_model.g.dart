// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClinicModel _$ClinicModelFromJson(Map<String, dynamic> json) => _ClinicModel(
  clinicId: (json['clinicId'] as num?)?.toInt() ?? 0,
  userId: (json['userId'] as num?)?.toInt() ?? 0,
  name: json['name'] as String? ?? '',
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  patients:
      (json['patients'] as List<dynamic>?)
          ?.map((e) => PatientModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ClinicModelToJson(_ClinicModel instance) =>
    <String, dynamic>{
      'clinicId': instance.clinicId,
      'userId': instance.userId,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'patients': instance.patients,
    };
