import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PatientModel', () {
    test('should create a PatientModel from JSON', () {
      final json = {
        'patientId': 1,
        'clinicId': 10,
        'name': 'John Doe',
        'profilePhotoUrl': 'https://example.com/photo.jpg',
        'description': 'Paciente ativo da pasta',
        'createdAt': '2024-01-01T00:00:00Z',
        'updatedAt': '2024-01-02T00:00:00Z',
      };

      final patient = PatientModel.fromJson(json);

      expect(patient.patientId, 1);
      expect(patient.clinicId, 10);
      expect(patient.name, 'John Doe');
      expect(patient.profilePhotoUrl, 'https://example.com/photo.jpg');
      expect(patient.description, 'Paciente ativo da pasta');
      expect(patient.createdAt, DateTime.parse('2024-01-01T00:00:00Z'));
      expect(patient.updatedAt, DateTime.parse('2024-01-02T00:00:00Z'));
    });

    test('should create a PatientModel with null optional fields', () {
      final json = {
        'patientId': 2,
        'clinicId': 20,
        'name': 'Jane Smith',
        'createdAt': '2024-01-01T00:00:00Z',
        'updatedAt': '2024-01-02T00:00:00Z',
      };

      final patient = PatientModel.fromJson(json);

      expect(patient.patientId, 2);
      expect(patient.clinicId, 20);
      expect(patient.name, 'Jane Smith');
      expect(patient.profilePhotoUrl, isNull);
      expect(patient.description, isNull);
    });

    test('should convert PatientModel to JSON', () {
      final patient = PatientModel(
        patientId: 1,
        clinicId: 10,
        name: 'John Doe',
        profilePhotoUrl: 'https://example.com/photo.jpg',
        description: 'Paciente ativo da pasta',
        createdAt: DateTime.parse('2024-01-01T00:00:00Z'),
        updatedAt: DateTime.parse('2024-01-02T00:00:00Z'),
      );

      final json = patient.toJson();

      expect(json['patientId'], 1);
      expect(json['clinicId'], 10);
      expect(json['name'], 'John Doe');
      expect(json['profilePhotoUrl'], 'https://example.com/photo.jpg');
      expect(json['description'], 'Paciente ativo da pasta');
      expect(json['createdAt'], '2024-01-01T00:00:00.000Z');
      expect(json['updatedAt'], '2024-01-02T00:00:00.000Z');
    });

    test('should use default values when fields are missing', () {
      final json = {
        'createdAt': '2024-01-01T00:00:00Z',
        'updatedAt': '2024-01-02T00:00:00Z',
      };

      final patient = PatientModel.fromJson(json);

      expect(patient.patientId, 0);
      expect(patient.clinicId, 0);
      expect(patient.name, '');
    });
  });
}

