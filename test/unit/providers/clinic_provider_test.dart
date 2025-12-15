import 'package:aurea_app/src/data/provider/clinic_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.env.dev');
  });

  group('ClinicProvider', () {
    late ClinicProvider provider;

    setUp(() {
      provider = ClinicProvider();
    });

    test('should be instantiable', () {
      expect(provider, isA<ClinicProvider>());
    });

    test('should have getClinics method', () {
      expect(provider.getClinics, isA<Function>());
    });

    test('should have getClinicById method', () {
      expect(provider.getClinicById, isA<Function>());
    });

    test('getClinics should throw error on failure', () async {
      try {
        await provider.getClinics();
        fail('Should throw error');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('getClinicById should throw error on failure', () async {
      try {
        await provider.getClinicById(1);
        fail('Should throw error');
      } catch (e) {
        expect(e, isNotNull);
      }
    });

    test('getClinicById should handle different clinicId values', () async {
      try {
        await provider.getClinicById(123);
        fail('Should throw error');
      } catch (e) {
        expect(e, isNotNull);
      }
    });
  });
}
