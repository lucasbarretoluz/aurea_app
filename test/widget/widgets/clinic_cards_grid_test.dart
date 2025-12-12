import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/presentation/widgets/clinic/clinic_cards_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ClinicCardsGrid', () {
    testWidgets('should display patients and add card', (WidgetTester tester) async {
      final patients = [
        PatientModel(
          patientId: 1,
          clinicId: 1,
          name: 'John Doe',
          description: 'Paciente ativo',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        PatientModel(
          patientId: 2,
          clinicId: 1,
          name: 'Jane Smith',
          description: 'Paciente ativo',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClinicCardsGrid(
              patients: patients,
              category: 'Clínica A',
            ),
          ),
        ),
      );

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Jane Smith'), findsOneWidget);
      expect(find.byType(ClinicCardsGrid), findsOneWidget);
    });

    testWidgets('should display add card as last item', (WidgetTester tester) async {
      final patients = [
        PatientModel(
          patientId: 1,
          clinicId: 1,
          name: 'John Doe',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClinicCardsGrid(
              patients: patients,
              category: 'Clínica A',
            ),
          ),
        ),
      );

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should display only add card when no patients', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClinicCardsGrid(
              patients: [],
              category: 'Clínica A',
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should render ListView horizontally', (WidgetTester tester) async {
      final patients = [
        PatientModel(
          patientId: 1,
          clinicId: 1,
          name: 'John Doe',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClinicCardsGrid(
              patients: patients,
              category: 'Clínica A',
            ),
          ),
        ),
      );

      final listView = tester.widget<ListView>(find.byType(ListView));
      expect(listView.scrollDirection, Axis.horizontal);
    });
  });
}

