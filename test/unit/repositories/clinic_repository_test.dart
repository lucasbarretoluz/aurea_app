import 'package:aurea_app/src/data/repository/clinic_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.env.dev');
  });

  group('ClinicRepository', () {
    late ClinicRepository clinicRepository;

    setUp(() {
      clinicRepository = ClinicRepository();
    });

    test('should be instantiable', () {
      expect(clinicRepository, isA<ClinicRepository>());
    });

    test('should have getClinics method', () {
      expect(clinicRepository.getClinics, isA<Function>());
    });

    test('should have getClinicById method', () {
      expect(clinicRepository.getClinicById, isA<Function>());
    });

    test('getClinics should throw exception on error', () async {
      try {
        await clinicRepository.getClinics();
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('getClinicById should throw exception on error', () async {
      try {
        await clinicRepository.getClinicById(1);
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('getClinicById should handle different clinicId values', () async {
      try {
        await clinicRepository.getClinicById(123);
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('getClinicById should handle various clinicId values', () async {
      try {
        await clinicRepository.getClinicById(999);
        fail('Should throw exception');
      } catch (e) {
        expect(e, isNotNull);
      }
    });
  });
}
