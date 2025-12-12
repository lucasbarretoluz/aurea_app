import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:aurea_app/src/presentation/screens/home/config_home_page.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.env.dev');
  });

  group('HomePage', () {
    testWidgets('should render the home page', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ConfigHomePage(),
        ),
      );

      await tester.pump();
      expect(find.byType(ConfigHomePage), findsOneWidget);
      
      await tester.pump(const Duration(seconds: 2));
    });
  });
}

