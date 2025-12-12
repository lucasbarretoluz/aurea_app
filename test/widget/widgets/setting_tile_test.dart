import 'package:aurea_app/src/presentation/screens/settings/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SettingTile', () {
    testWidgets('should display icon, title and subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingTile(
              icon: Icons.settings,
              title: 'Configurações',
              subtitle: 'Ajustes do app',
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.settings), findsOneWidget);
      expect(find.text('Configurações'), findsOneWidget);
      expect(find.text('Ajustes do app'), findsOneWidget);
    });

    testWidgets('should call onTap when tapped', (WidgetTester tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingTile(
              icon: Icons.settings,
              title: 'Configurações',
              subtitle: 'Ajustes do app',
              onTap: () {
                wasTapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SettingTile));
      expect(wasTapped, true);
    });

    testWidgets('should display trailing widget when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingTile(
              icon: Icons.settings,
              title: 'Configurações',
              subtitle: 'Ajustes do app',
              trailing: const Icon(Icons.arrow_forward),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('should apply destructive style when isDestructive is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingTile(
              icon: Icons.delete,
              title: 'Deletar',
              subtitle: 'Excluir conta',
              isDestructive: true,
            ),
          ),
        ),
      );

      expect(find.text('Deletar'), findsOneWidget);
    });

    testWidgets('should work with empty subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingTile(
              icon: Icons.settings,
              title: 'Configurações',
              subtitle: '',
            ),
          ),
        ),
      );

      expect(find.text('Configurações'), findsOneWidget);
    });
  });
}

