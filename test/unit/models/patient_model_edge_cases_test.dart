import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PatientModel Edge Cases', () {
    test('should handle very long name', () {
      final longName = 'A' * 1000;
      final json = {
        'patientId': 1,
        'clinicId': 10,
        'name': longName,
        'createdAt': '2024-01-01T00:00:00Z',
        'updatedAt': '2024-01-02T00:00:00Z',
      };

      final patient = PatientModel.fromJson(json);

      expect(patient.name, longName);
      expect(patient.name.length, 1000);
    });

    test('should handle special characters in name', () {
      final specialName = 'João da Silva & Cia. - 123';
      final json = {
        'patientId': 1,
        'clinicId': 10,
        'name': specialName,
        'createdAt': '2024-01-01T00:00:00Z',
        'updatedAt': '2024-01-02T00:00:00Z',
      };

      final patient = PatientModel.fromJson(json);

      expect(patient.name, specialName);
    });

    test('should handle very long description', () {
      final longDescription = 'Descrição muito longa ' * 100;
      final json = {
        'patientId': 1,
        'clinicId': 10,
        'name': 'John Doe',
        'description': longDescription,
        'createdAt': '2024-01-01T00:00:00Z',
        'updatedAt': '2024-01-02T00:00:00Z',
      };

      final patient = PatientModel.fromJson(json);

      expect(patient.description, longDescription);
    });

    test('should handle invalid date format gracefully', () {
      final json = {
        'patientId': 1,
        'clinicId': 10,
        'name': 'John Doe',
        'createdAt': 'invalid-date',
        'updatedAt': '2024-01-02T00:00:00Z',
      };

      expect(() => PatientModel.fromJson(json), throwsA(isA<FormatException>()));
    });

    test('should handle large patientId values', () {
      final json = {
        'patientId': 9223372036854775807,
        'clinicId': 10,
        'name': 'John Doe',
        'createdAt': '2024-01-01T00:00:00Z',
        'updatedAt': '2024-01-02T00:00:00Z',
      };

      final patient = PatientModel.fromJson(json);

      expect(patient.patientId, 9223372036854775807);
    });
  });
}

