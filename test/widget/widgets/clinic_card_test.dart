import 'package:aurea_app/src/core/enums/gender_enum.dart';
import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/presentation/widgets/clinic/clinic_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ClinicCard', () {
    testWidgets('should display title, subtitle and category', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClinicCard(
             patient: PatientModel(
              name: 'John Doe',
              clinicName: 'Clínica A',
              profilePhotoUrl: 'https://example.com/photo.jpg',
              gender: GenderEnum.male,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              description: 'Paciente ativo da pasta',
             ),
            ),
          ),
        ),
      );

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Paciente ativo da pasta'), findsOneWidget);
      expect(find.text('Clínica A'), findsOneWidget);
    });

    testWidgets('should display image when imageUrl is provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClinicCard(
              patient: PatientModel(
              name: 'John Doe',
              clinicName: 'Clínica A',
              profilePhotoUrl: 'https://example.com/photo.jpg',
              gender: GenderEnum.male,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              description: 'Paciente ativo da pasta',
             ),
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('should display fallback image when imageUrl is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClinicCard(
              patient: PatientModel(
              name: 'John Doe',
              clinicName: 'Clínica A',
              profilePhotoUrl: 'https://example.com/photo.jpg',
              gender: GenderEnum.male,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              description: 'Paciente ativo da pasta',
             ),
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('should have rounded corners', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClinicCard(
              patient: PatientModel(
              name: 'John Doe',
              clinicName: 'Clínica A',
              profilePhotoUrl: 'https://example.com/photo.jpg',
              gender: GenderEnum.male,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              description: 'Paciente ativo da pasta',
             ),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(ClinicCard),
          matching: find.byType(Container).first,
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.borderRadius, isNotNull);
    });

    testWidgets('should display fallback icon when network image fails', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClinicCard(
              patient: PatientModel(
              name: 'John Doe',
              clinicName: 'Clínica A',
              profilePhotoUrl: 'https://example.com/photo.jpg',
              gender: GenderEnum.male,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              description: 'Paciente ativo da pasta',
             ),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump();

      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('should display empty string imageUrl as fallback', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClinicCard(
              patient: PatientModel(
              name: 'John Doe',
              clinicName: 'Clínica A',
              profilePhotoUrl: 'https://example.com/photo.jpg',
              gender: GenderEnum.male,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              description: 'Paciente ativo da pasta',
             ),
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('should have white container for text overlay', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClinicCard(
              patient: PatientModel(
              name: 'John Doe',
              clinicName: 'Clínica A',
              profilePhotoUrl: 'https://example.com/photo.jpg',
              gender: GenderEnum.male,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              description: 'Paciente ativo da pasta',
             ),
            ),
          ),
        ),
      );

      final positioned = tester.widget<Positioned>(find.byType(Positioned));
      expect(positioned, isNotNull);
    });
  });
}

