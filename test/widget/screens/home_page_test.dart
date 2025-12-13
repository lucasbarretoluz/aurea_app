import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:aurea_app/src/logic/cubit/clinic/clinic_cubit.dart';
import 'package:aurea_app/src/logic/cubit/patient/patient_cubit.dart';
import 'package:aurea_app/src/logic/cubit/patient/patient_state.dart';
import 'package:aurea_app/src/presentation/screens/home/config_home_page.dart';

class MockClinicCubit extends Mock implements ClinicCubit {}
class MockPatientCubit extends Mock implements PatientCubit {}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.env.dev');
  });

  group('HomePage', () {
    testWidgets('should render the home page', (WidgetTester tester) async {
      final mockClinicCubit = MockClinicCubit();
      final mockPatientCubit = MockPatientCubit();
      
      when(() => mockClinicCubit.state).thenReturn(const ClinicState.initial());
      when(() => mockClinicCubit.stream).thenAnswer((_) => const Stream.empty());
      when(() => mockClinicCubit.loadClinics()).thenAnswer((_) async {});
      when(() => mockPatientCubit.state).thenReturn(const PatientState.initial());
      when(() => mockPatientCubit.stream).thenAnswer((_) => const Stream.empty());
      when(() => mockPatientCubit.loadPatients(
        page: any(named: 'page'),
        limit: any(named: 'limit'),
        loadMore: any(named: 'loadMore'),
      )).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<ClinicCubit>.value(value: mockClinicCubit),
              BlocProvider<PatientCubit>.value(value: mockPatientCubit),
            ],
            child: const ConfigHomePage(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump();
      expect(find.byType(ConfigHomePage), findsOneWidget);
      
      // Aguarda qualquer callback assíncrono
      await tester.binding.delayed(const Duration(milliseconds: 100));
      await tester.pump();
    });
  });
}

