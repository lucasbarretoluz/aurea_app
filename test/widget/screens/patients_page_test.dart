import 'package:aurea_app/src/logic/cubit/patient/patient_cubit.dart';
import 'package:aurea_app/src/logic/cubit/patient/patient_state.dart';
import 'package:aurea_app/src/presentation/screens/patients_add/all_patients_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPatientCubit extends Mock implements PatientCubit {}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.env.dev');
  });

  group('PatientsPage', () {
    testWidgets('should render the patients page', (WidgetTester tester) async {
      final mockCubit = MockPatientCubit();
      when(() => mockCubit.state).thenReturn(const PatientState.initial());
      when(() => mockCubit.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<PatientCubit>.value(
            value: mockCubit,
            child: const AllPatientsPageView(),
          ),
        ),
      );

      await tester.pump();
      expect(find.byType(AllPatientsPageView), findsOneWidget);
      expect(find.text('Todos os Pacientes'), findsOneWidget);
    });

    testWidgets('should display loading indicator when loading', (WidgetTester tester) async {
      final mockCubit = MockPatientCubit();
      when(() => mockCubit.state).thenReturn(const PatientState.loading());
      when(() => mockCubit.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<PatientCubit>.value(
            value: mockCubit,
            child: const AllPatientsPageView(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display error message when error occurs', (WidgetTester tester) async {
      final mockCubit = MockPatientCubit();
      when(() => mockCubit.state).thenReturn(
        const PatientState.error('Erro ao carregar pacientes'),
      );
      when(() => mockCubit.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<PatientCubit>.value(
            value: mockCubit,
            child: const AllPatientsPageView(),
          ),
        ),
      );

      expect(find.text('Erro: Erro ao carregar pacientes'), findsOneWidget);
    });

    testWidgets('should display empty message when no patients', (WidgetTester tester) async {
      final mockCubit = MockPatientCubit();
      when(() => mockCubit.state).thenReturn(
        const PatientState.loaded(
          patients: [],
          total: 0,
          page: 1,
          limit: 20,
          hasMore: false,
        ),
      );
      when(() => mockCubit.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<PatientCubit>.value(
            value: mockCubit,
            child: const AllPatientsPageView(),
          ),
        ),
      );

      expect(find.text('Nenhum paciente encontrado'), findsOneWidget);
    });
  });
}

