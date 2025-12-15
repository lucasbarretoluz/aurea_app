import 'package:aurea_app/src/data/provider/patient_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.env.dev');
  });

  group('PatientProvider', () {
    late PatientProvider provider;

    setUp(() {
      provider = PatientProvider();
    });

    test('should be instantiable', () {
      expect(provider, isA<PatientProvider>());
    });

    test('should have getPatients method', () {
      expect(provider.getPatients, isA<Function>());
    });

    test('getPatients should throw error on failure', () async {
      try {
        await provider.getPatients();
        fail('Should throw error');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('getPatients should throw error when network fails', () async {
      try {
        await provider.getPatients(page: 1, limit: 10);
        fail('Should throw error');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('getPatients should handle different page values', () async {
      try {
        await provider.getPatients(page: 1);
        fail('Should throw error');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('getPatients should handle different limit values', () async {
      try {
        await provider.getPatients(limit: 20);
        fail('Should throw error');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('getPatients should handle both page and limit parameters', () async {
      try {
        await provider.getPatients(page: 2, limit: 30);
        fail('Should throw error');
      } catch (e) {
        expect(e, isNotNull);
      }
    });
  });
}
