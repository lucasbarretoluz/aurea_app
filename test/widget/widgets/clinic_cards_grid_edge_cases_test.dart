import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/presentation/widgets/clinic/clinic_card.dart';
import 'package:aurea_app/src/presentation/widgets/clinic/clinic_cards_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ClinicCardsGrid Edge Cases', () {
    testWidgets('should handle many patients', (WidgetTester tester) async {
      final patients = List.generate(
        20,
        (index) => PatientModel(
          patientId: index,
          clinicId: 1,
          name: 'Patient $index',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

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

      await tester.pump();
      expect(find.text('Patient 0'), findsOneWidget);
      expect(find.byType(ClinicCard), findsWidgets);
    });

    testWidgets('should handle patients with very long names', (WidgetTester tester) async {
      final longName = 'A' * 100;
      final patients = [
        PatientModel(
          patientId: 1,
          clinicId: 1,
          name: longName,
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

      expect(find.text(longName), findsOneWidget);
    });

    testWidgets('should handle patients with special characters in names', (WidgetTester tester) async {
      final patients = [
        PatientModel(
          patientId: 1,
          clinicId: 1,
          name: 'João & Maria - 123',
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

      expect(find.text('João & Maria - 123'), findsOneWidget);
    });

    testWidgets('should handle patients with network image URLs', (WidgetTester tester) async {
      final patients = [
        PatientModel(
          patientId: 1,
          clinicId: 1,
          name: 'John Doe',
          profilePhotoUrl: 'https://example.com/photo.jpg',
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
      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('should maintain correct item count', (WidgetTester tester) async {
      final patients = [
        PatientModel(
          patientId: 1,
          clinicId: 1,
          name: 'Patient 1',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        PatientModel(
          patientId: 2,
          clinicId: 1,
          name: 'Patient 2',
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

      expect(find.text('Patient 1'), findsOneWidget);
      expect(find.text('Patient 2'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });
  });
}

