// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_paginated_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PatientPaginatedResponse _$PatientPaginatedResponseFromJson(
  Map<String, dynamic> json,
) => _PatientPaginatedResponse(
  limit: (json['limit'] as num?)?.toInt() ?? 0,
  page: (json['page'] as num?)?.toInt() ?? 0,
  patients:
      (json['patients'] as List<dynamic>?)
          ?.map((e) => PatientModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  total: (json['total'] as num?)?.toInt() ?? 0,
  totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$PatientPaginatedResponseToJson(
  _PatientPaginatedResponse instance,
) => <String, dynamic>{
  'limit': instance.limit,
  'page': instance.page,
  'patients': instance.patients,
  'total': instance.total,
  'totalPages': instance.totalPages,
};
