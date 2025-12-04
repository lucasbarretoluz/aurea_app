import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aurea_app/src/presentation/screens/splash/splash_page.dart';

void main() {
  group('SplashPage', () {
    testWidgets('should render the splash page', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SplashPage(),
        ),
      );

      expect(find.byType(SplashPage), findsOneWidget);
    });
  });
}

