import 'package:aurea_app/src/presentation/screens/settings/widgets/setting_section.dart';
import 'package:aurea_app/src/presentation/screens/settings/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SettingSection', () {
    testWidgets('should display title', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingSection(
              title: 'Segurança',
              children: const [],
            ),
          ),
        ),
      );

      expect(find.text('Segurança'), findsOneWidget);
    });

    testWidgets('should display all children', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingSection(
              title: 'Conta',
              children: [
                SettingTile(
                  icon: Icons.person,
                  title: 'Perfil',
                  subtitle: 'Editar perfil',
                ),
                SettingTile(
                  icon: Icons.logout,
                  title: 'Sair',
                  subtitle: 'Encerrar sessão',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Perfil'), findsOneWidget);
      expect(find.text('Sair'), findsOneWidget);
    });

    testWidgets('should handle empty children list', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingSection(
              title: 'Vazio',
              children: const [],
            ),
          ),
        ),
      );

      expect(find.text('Vazio'), findsOneWidget);
    });
  });
}

