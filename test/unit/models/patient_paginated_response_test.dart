import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/data/models/patient/patient_paginated_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PatientPaginatedResponse', () {
    test('should create PatientPaginatedResponse from JSON', () {
      final json = {
        'patients': [
          {
            'patientId': 1,
            'clinicId': 10,
            'name': 'John Doe',
            'createdAt': '2024-01-01T00:00:00Z',
            'updatedAt': '2024-01-02T00:00:00Z',
          },
          {
            'patientId': 2,
            'clinicId': 20,
            'name': 'Jane Smith',
            'createdAt': '2024-01-01T00:00:00Z',
            'updatedAt': '2024-01-02T00:00:00Z',
          },
        ],
        'total': 2,
        'page': 1,
        'limit': 10,
        'totalPages': 1,
      };

      final response = PatientPaginatedResponse.fromJson(json);

      expect(response.patients.length, 2);
      expect(response.patients[0].name, 'John Doe');
      expect(response.patients[1].name, 'Jane Smith');
      expect(response.total, 2);
      expect(response.page, 1);
      expect(response.limit, 10);
      expect(response.totalPages, 1);
    });

    test('should convert PatientPaginatedResponse to JSON', () {
      final patients = [
        PatientModel(
          patientId: 1,
          clinicId: 10,
          name: 'John Doe',
          createdAt: DateTime.parse('2024-01-01T00:00:00Z'),
          updatedAt: DateTime.parse('2024-01-02T00:00:00Z'),
        ),
        PatientModel(
          patientId: 2,
          clinicId: 20,
          name: 'Jane Smith',
          createdAt: DateTime.parse('2024-01-01T00:00:00Z'),
          updatedAt: DateTime.parse('2024-01-02T00:00:00Z'),
        ),
      ];

      final response = PatientPaginatedResponse(
        patients: patients,
        total: 2,
        page: 1,
        limit: 10,
        totalPages: 1,
      );

      final json = response.toJson();

      expect(json['patients'], isA<List>());
      expect((json['patients'] as List).length, 2);
      expect(json['total'], 2);
      expect(json['page'], 1);
      expect(json['limit'], 10);
      expect(json['totalPages'], 1);
    });

    test('should use default values when fields are missing', () {
      final json = <String, dynamic>{};

      final response = PatientPaginatedResponse.fromJson(json);

      expect(response.patients, isEmpty);
      expect(response.total, 0);
      expect(response.page, 0);
      expect(response.limit, 0);
      expect(response.totalPages, 0);
    });

    test('should handle empty data list', () {
      final json = {
        'patients': [],
        'total': 0,
        'page': 1,
        'limit': 10,
        'totalPages': 0,
      };

      final response = PatientPaginatedResponse.fromJson(json);

      expect(response.patients, isEmpty);
      expect(response.total, 0);
      expect(response.totalPages, 0);
    });

    test('should handle pagination correctly', () {
      final json = {
        'patients': [],
        'total': 25,
        'page': 2,
        'limit': 10,
        'totalPages': 3,
      };

      final response = PatientPaginatedResponse.fromJson(json);

      expect(response.total, 25);
      expect(response.page, 2);
      expect(response.limit, 10);
      expect(response.totalPages, 3);
    });
  });
}

