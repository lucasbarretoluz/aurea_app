import 'package:aurea_app/src/data/models/clinic/clinic_model.dart';
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

    group('createClinic', () {
      test('should return a Future<ClinicModel>', () {
        expect(
          clinicCubit.createClinic('Nova clínica'),
          isA<Future<ClinicModel>>(),
        );
      });
    });

    group('updateClinic', () {
      test('should return a Future<ClinicModel>', () {
        expect(
          clinicCubit.updateClinic(clinicId: 1, name: 'Clínica atualizada'),
          isA<Future<ClinicModel>>(),
        );
      });
    });

    group('deleteClinic', () {
      test('should be an async method', () {
        expect(
          clinicCubit.deleteClinic(1),
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

