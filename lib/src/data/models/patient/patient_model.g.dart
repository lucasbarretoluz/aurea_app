// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PatientModel _$PatientModelFromJson(Map<String, dynamic> json) =>
    _PatientModel(
      patientId: (json['patientId'] as num?)?.toInt() ?? 0,
      clinicId: (json['clinicId'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PatientModelToJson(_PatientModel instance) =>
    <String, dynamic>{
      'patientId': instance.patientId,
      'clinicId': instance.clinicId,
      'name': instance.name,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
