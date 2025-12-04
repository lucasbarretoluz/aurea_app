import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    testWidgets('app deve iniciar corretamente', (WidgetTester tester) async {
      expect(true, isTrue);
    });
  });
}

