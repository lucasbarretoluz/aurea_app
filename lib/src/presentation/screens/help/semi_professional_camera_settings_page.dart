import 'package:aurea_app/src/presentation/screens/help/widgets/help_page_scaffold.dart';
import 'package:flutter/material.dart';

class SemiProfessionalCameraSettingsPage extends StatelessWidget {
  const SemiProfessionalCameraSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return HelpPageScaffold(
      child: const Center(
        child: Text('Configurações de câmera semiprofissional'),
      ),
    );
  }
}

