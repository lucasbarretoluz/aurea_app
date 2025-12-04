import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aurea_app/src/presentation/screens/login/login_page.dart';

void main() {
  group('LoginPage', () {
    testWidgets('should render the login page', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginPage(),
        ),
      );

      expect(find.byType(LoginPage), findsOneWidget);
      expect(find.byType(LoginPageView), findsOneWidget);
    });
  });
}

