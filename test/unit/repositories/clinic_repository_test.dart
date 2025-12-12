import 'package:aurea_app/src/data/models/clinic/clinic_model.dart';
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

    group('getClinics', () {
      test('should be an async method that returns Future<List<ClinicModel>>', () {
        expect(
          clinicRepository.getClinics(),
          isA<Future<List<ClinicModel>>>(),
        );
      });
    });

    group('getClinicById', () {
      test('should be an async method that returns Future<ClinicModel>', () {
        expect(
          clinicRepository.getClinicById(1),
          isA<Future<ClinicModel>>(),
        );
      });
    });
  });
}

