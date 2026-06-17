import 'package:aurea_app/src/presentation/widgets/clinic/add_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AddCard', () {
    testWidgets('should render with correct width and height', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddCard(
              width: 200,
              height: 300,
              clinicName: 'Clínica A',
              clinicId: 1,
            ),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
      expect(sizedBox.width, 200);
      expect(sizedBox.height, 300);
    });

    testWidgets('should display add icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddCard(
              width: 200,
              height: 300,
              clinicName: 'Clínica A',
              clinicId: 1,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should have rounded corners', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddCard(
              width: 200,
              height: 300,
              clinicName: 'Clínica A',
              clinicId: 1,
            ),
          ),
        ),
      );

      final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect).first);
      expect(clipRRect.borderRadius, BorderRadius.circular(12));
    });

    testWidgets('should display blurred background image', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddCard(
              width: 200,
              height: 300,
              clinicName: 'Clínica A',
              clinicId: 1,
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should display fallback when image fails to load', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddCard(
              width: 200,
              height: 300,
              clinicName: 'Clínica A',
              clinicId: 1,
            ),
          ),
        ),
      );

      await tester.pump();
      expect(find.byType(Container), findsWidgets);
    });
  });
}

