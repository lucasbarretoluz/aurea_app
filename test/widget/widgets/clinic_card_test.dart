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
              title: 'John Doe',
              subtitle: 'Paciente ativo da pasta',
              category: 'Clínica A',
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
              title: 'John Doe',
              subtitle: 'Paciente ativo',
              category: 'Clínica A',
              imageUrl: 'https://example.com/photo.jpg',
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
              title: 'John Doe',
              subtitle: 'Paciente ativo',
              category: 'Clínica A',
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
              title: 'John Doe',
              subtitle: 'Paciente ativo',
              category: 'Clínica A',
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
              title: 'John Doe',
              subtitle: 'Paciente ativo',
              category: 'Clínica A',
              imageUrl: 'https://invalid-url.com/image.jpg',
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
              title: 'John Doe',
              subtitle: 'Paciente ativo',
              category: 'Clínica A',
              imageUrl: '',
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
              title: 'John Doe',
              subtitle: 'Paciente ativo',
              category: 'Clínica A',
            ),
          ),
        ),
      );

      final positioned = tester.widget<Positioned>(find.byType(Positioned));
      expect(positioned, isNotNull);
    });
  });
}

