import 'package:aurea_app/src/logic/cubit/clinic/clinic_cubit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.env.dev');
  });

  group('ClinicCubit', () {
    late ClinicCubit clinicCubit;

    setUp(() {
      clinicCubit = ClinicCubit();
    });

    tearDown(() {
      clinicCubit.close();
    });

    test('initial state should be ClinicState.initial', () {
      expect(clinicCubit.state, const ClinicState.initial());
    });

    group('loadClinics', () {
      test('should be an async method', () {
        expect(
          clinicCubit.loadClinics(),
          isA<Future<void>>(),
        );
      });
    });

    group('loadClinicById', () {
      test('should be an async method', () {
        expect(
          clinicCubit.loadClinicById(1),
          isA<Future<void>>(),
        );
      });
    });
  });
}

