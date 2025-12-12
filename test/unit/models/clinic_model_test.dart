import 'package:aurea_app/src/data/models/clinic/clinic_model.dart';
import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ClinicModel', () {
    test('should create a ClinicModel from JSON with patients', () {
      final json = {
        'clinicId': 1,
        'userId': 100,
        'name': 'Clínica A',
        'createdAt': '2024-01-01T00:00:00Z',
        'updatedAt': '2024-01-02T00:00:00Z',
        'patients': [
          {
            'patientId': 1,
            'clinicId': 1,
            'name': 'John Doe',
            'profilePhotoUrl': 'https://example.com/photo.jpg',
            'description': 'Paciente ativo',
            'createdAt': '2024-01-01T00:00:00Z',
            'updatedAt': '2024-01-02T00:00:00Z',
          },
          {
            'patientId': 2,
            'clinicId': 1,
            'name': 'Jane Smith',
            'createdAt': '2024-01-01T00:00:00Z',
            'updatedAt': '2024-01-02T00:00:00Z',
          },
        ],
      };

      final clinic = ClinicModel.fromJson(json);

      expect(clinic.clinicId, 1);
      expect(clinic.userId, 100);
      expect(clinic.name, 'Clínica A');
      expect(clinic.patients.length, 2);
      expect(clinic.patients[0].name, 'John Doe');
      expect(clinic.patients[1].name, 'Jane Smith');
    });

    test('should create a ClinicModel from JSON without patients', () {
      final json = {
        'clinicId': 2,
        'userId': 200,
        'name': 'Clínica B',
        'createdAt': '2024-01-01T00:00:00Z',
        'updatedAt': '2024-01-02T00:00:00Z',
      };

      final clinic = ClinicModel.fromJson(json);

      expect(clinic.clinicId, 2);
      expect(clinic.userId, 200);
      expect(clinic.name, 'Clínica B');
      expect(clinic.patients, isEmpty);
    });

    test('should convert ClinicModel to JSON with patients', () {
      final clinic = ClinicModel(
        clinicId: 1,
        userId: 100,
        name: 'Clínica A',
        createdAt: DateTime.parse('2024-01-01T00:00:00Z'),
        updatedAt: DateTime.parse('2024-01-02T00:00:00Z'),
        patients: [
          PatientModel(
            patientId: 1,
            clinicId: 1,
            name: 'John Doe',
            createdAt: DateTime.parse('2024-01-01T00:00:00Z'),
            updatedAt: DateTime.parse('2024-01-02T00:00:00Z'),
          ),
        ],
      );

      final json = clinic.toJson();

      expect(json['clinicId'], 1);
      expect(json['userId'], 100);
      expect(json['name'], 'Clínica A');
      expect(json['patients'], isA<List>());
      expect((json['patients'] as List).length, 1);
    });

    test('should use default values when fields are missing', () {
      final json = {
        'createdAt': '2024-01-01T00:00:00Z',
        'updatedAt': '2024-01-02T00:00:00Z',
      };

      final clinic = ClinicModel.fromJson(json);

      expect(clinic.clinicId, 0);
      expect(clinic.userId, 0);
      expect(clinic.name, '');
      expect(clinic.patients, isEmpty);
    });

    test('should handle null patients array in JSON', () {
      final json = {
        'clinicId': 1,
        'userId': 100,
        'name': 'Clínica A',
        'createdAt': '2024-01-01T00:00:00Z',
        'updatedAt': '2024-01-02T00:00:00Z',
        'patients': null,
      };

      final clinic = ClinicModel.fromJson(json);

      expect(clinic.clinicId, 1);
      expect(clinic.patients, isEmpty);
    });

    test('should convert to JSON with empty patients list', () {
      final clinic = ClinicModel(
        clinicId: 1,
        userId: 100,
        name: 'Clínica A',
        createdAt: DateTime.parse('2024-01-01T00:00:00Z'),
        updatedAt: DateTime.parse('2024-01-02T00:00:00Z'),
        patients: const [],
      );

      final json = clinic.toJson();

      expect(json['patients'], isA<List>());
      expect((json['patients'] as List).isEmpty, true);
    });
  });
}

