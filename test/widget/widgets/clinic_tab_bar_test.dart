import 'package:aurea_app/src/presentation/widgets/clinic/clinic_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ClinicTabBar', () {
    testWidgets('should display all tabs', (WidgetTester tester) async {
      final tabs = ['Templates', 'Consultório', 'Clínica A'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClinicTabBar(
              tabs: tabs,
              selectedIndex: 0,
              onTabSelected: (index) {},
            ),
          ),
        ),
      );

      expect(find.text('Templates'), findsOneWidget);
      expect(find.text('Consultório'), findsOneWidget);
      expect(find.text('Clínica A'), findsOneWidget);
    });

    testWidgets('should highlight selected tab', (WidgetTester tester) async {
      final tabs = ['Templates', 'Consultório', 'Clínica A'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClinicTabBar(
              tabs: tabs,
              selectedIndex: 1,
              onTabSelected: (index) {},
            ),
          ),
        ),
      );

      final selectedText = tester.widget<Text>(find.text('Consultório'));
      expect(selectedText.style?.fontWeight, FontWeight.w600);
    });

    testWidgets('should call onTabSelected when tab is tapped', (WidgetTester tester) async {
      final tabs = ['Templates', 'Consultório'];
      int? selectedIndex;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClinicTabBar(
              tabs: tabs,
              selectedIndex: 0,
              onTabSelected: (index) {
                selectedIndex = index;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Consultório'));
      expect(selectedIndex, 1);
    });

    testWidgets('should display add button', (WidgetTester tester) async {
      final tabs = ['Templates'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClinicTabBar(
              tabs: tabs,
              selectedIndex: 0,
              onTabSelected: (index) {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should call onAddPressed when add button is tapped', (WidgetTester tester) async {
      final tabs = ['Templates'];
      bool addPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClinicTabBar(
              tabs: tabs,
              selectedIndex: 0,
              onTabSelected: (index) {},
              onAddPressed: () {
                addPressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.add));
      expect(addPressed, true);
    });

    testWidgets('should handle empty tabs list', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClinicTabBar(
              tabs: [],
              selectedIndex: 0,
              onTabSelected: (index) {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should show border on selected tab', (WidgetTester tester) async {
      final tabs = ['Templates', 'Consultório'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClinicTabBar(
              tabs: tabs,
              selectedIndex: 0,
              onTabSelected: (index) {},
            ),
          ),
        ),
      );

      final selectedText = tester.widget<Text>(find.text('Templates'));
      expect(selectedText.style?.fontWeight, FontWeight.w600);
      
      final unselectedText = tester.widget<Text>(find.text('Consultório'));
      expect(unselectedText.style?.fontWeight, FontWeight.normal);
    });
  });
}

