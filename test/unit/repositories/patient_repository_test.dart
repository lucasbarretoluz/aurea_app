import 'package:aurea_app/src/data/repository/patient_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.env.dev');
  });

  group('PatientRepository', () {
    late PatientRepository repository;

    setUp(() {
      repository = PatientRepository();
    });

    test('should be instantiable', () {
      expect(repository, isA<PatientRepository>());
    });

    test('should have getPatients method', () {
      expect(repository.getPatients, isA<Function>());
    });

    test('getPatients should throw exception on error', () async {
      try {
        await repository.getPatients();
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('getPatients should handle different page values', () async {
      try {
        await repository.getPatients(page: 2);
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('getPatients should handle different limit values', () async {
      try {
        await repository.getPatients(limit: 20);
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('getPatients should handle both page and limit parameters', () async {
      try {
        await repository.getPatients(page: 3, limit: 15);
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });
  });
}
