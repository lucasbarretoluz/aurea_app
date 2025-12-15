import 'package:aurea_app/src/presentation/screens/help/widgets/help_page_scaffold.dart';
import 'package:flutter/material.dart';

class PhotographicProtocolPage extends StatelessWidget {
  const PhotographicProtocolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return HelpPageScaffold(
      children: [
        Center(
          child: Text('Conteúdo da Coluna'),
        ),
      ],
    );
  }
}