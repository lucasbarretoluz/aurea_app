import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aurea_app/src/presentation/screens/home/config_home_page.dart';

void main() {
  group('HomePage', () {
    testWidgets('should render the home page', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ConfigHomePage(),
        ),
      );

      expect(find.byType(ConfigHomePage), findsOneWidget);
    });
  });
}

