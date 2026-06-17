import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/logic/cubit/patient/patient_cubit.dart';
import 'package:aurea_app/src/logic/cubit/patient/patient_state.dart';
import 'package:aurea_app/src/presentation/screens/home/widgets/all_patients_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockPatientCubit extends Mock implements PatientCubit {}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.env.dev');
  });

  group('AllPatientsSection', () {
    testWidgets('should display section title and ver todos button', (WidgetTester tester) async {
      final mockCubit = MockPatientCubit();
      when(() => mockCubit.state).thenReturn(
        PatientState.loaded(
          patients: [
            PatientModel(
              patientId: 1,
              clinicId: 1,
              name: 'John Doe',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ],
          total: 1,
          page: 1,
          limit: 5,
          hasMore: false,
        ),
      );
      when(() => mockCubit.stream).thenAnswer((_) => const Stream.empty());

      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => Scaffold(
              body: BlocProvider<PatientCubit>.value(
                value: mockCubit,
                child: const AllPatientsSection(),
              ),
            ),
          ),
          GoRoute(
            path: '/patients',
            builder: (context, state) => const Scaffold(body: Text('Patients Page')),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      expect(find.text('Todos os pacientes'), findsOneWidget);
      expect(find.text('Ver todos'), findsOneWidget);
    });

    testWidgets('should display patients in horizontal list', (WidgetTester tester) async {
      final patients = List.generate(
        5,
        (index) => PatientModel(
          patientId: index + 1,
          clinicId: 1,
          name: 'Patient ${index + 1}',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      final mockCubit = MockPatientCubit();
      when(() => mockCubit.state).thenReturn(
        PatientState.loaded(
          patients: patients,
          total: 5,
          page: 1,
          limit: 5,
          hasMore: false,
        ),
      );
      when(() => mockCubit.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<PatientCubit>.value(
              value: mockCubit,
              child: const AllPatientsSection(),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump();
      
      expect(find.text('Patient 1'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('should navigate to /patients when ver todos is clicked', (WidgetTester tester) async {
      final mockCubit = MockPatientCubit();
      when(() => mockCubit.state).thenReturn(
        PatientState.loaded(
          patients: [
            PatientModel(
              patientId: 1,
              clinicId: 1,
              name: 'John Doe',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ],
          total: 1,
          page: 1,
          limit: 5,
          hasMore: false,
        ),
      );
      when(() => mockCubit.stream).thenAnswer((_) => const Stream.empty());

      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => Scaffold(
              body: BlocProvider<PatientCubit>.value(
                value: mockCubit,
                child: const AllPatientsSection(),
              ),
            ),
          ),
          GoRoute(
            path: '/all-patients',
            builder: (context, state) => const Scaffold(
              body: Text('All Patients Page'),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      await tester.tap(find.text('Ver todos'));
      await tester.pumpAndSettle();

      expect(find.text('All Patients Page'), findsOneWidget);
    });

    testWidgets('should hide section when loading', (WidgetTester tester) async {
      final mockCubit = MockPatientCubit();
      when(() => mockCubit.state).thenReturn(const PatientState.loading());
      when(() => mockCubit.stream).thenAnswer((_) => const Stream.empty());
      when(() => mockCubit.loadPatients(page: any(named: 'page'), limit: any(named: 'limit'), loadMore: any(named: 'loadMore')))
          .thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<PatientCubit>.value(
              value: mockCubit,
              child: const AllPatientsSection(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Todos os pacientes'), findsNothing);
    });

    testWidgets('should hide section when state is not loaded or loading', (WidgetTester tester) async {
      final mockCubit = MockPatientCubit();
      when(() => mockCubit.state).thenReturn(const PatientState.initial());
      when(() => mockCubit.stream).thenAnswer((_) => const Stream.empty());
      when(() => mockCubit.loadPatients(page: any(named: 'page'), limit: any(named: 'limit'), loadMore: any(named: 'loadMore')))
          .thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<PatientCubit>.value(
              value: mockCubit,
              child: const AllPatientsSection(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Todos os pacientes'), findsNothing);
    });

    testWidgets('should not display patients list when empty', (WidgetTester tester) async {
      final mockCubit = MockPatientCubit();
      when(() => mockCubit.state).thenReturn(
        const PatientState.loaded(
          patients: [],
          total: 0,
          page: 1,
          limit: 5,
          hasMore: false,
        ),
      );
      when(() => mockCubit.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<PatientCubit>.value(
              value: mockCubit,
              child: const AllPatientsSection(),
            ),
          ),
        ),
      );

      expect(find.text('Todos os pacientes'), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
    });
  });
}

