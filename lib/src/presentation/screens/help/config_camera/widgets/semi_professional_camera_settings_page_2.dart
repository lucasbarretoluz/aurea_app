import 'package:flutter/material.dart';

class SemiProfessionalCameraSettingsPage2 extends StatelessWidget {
  const SemiProfessionalCameraSettingsPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(35.0, 45.0, 40.0, 0.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.5,
                ),
                children: [
                  const TextSpan(
                    text: 'O melhor padrão de iluminação para as fotografias odontológicas de diagnóstico é um ',
                  ),
                  TextSpan(
                    text: 'padrão multidirecional',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: ' - criando a menor quantidade de sombras possível. É possível atingir esse resultado utilizando mais de uma fonte de luz (com flashes do tipo ',
                  ),
                  TextSpan(
                    text: 'twin',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const TextSpan(
                    text: ' ou estúdio) ou uma fonte de luz circular.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text.rich(
              TextSpan(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.5,
                ),
                children: [
                  const TextSpan(
                    text: 'Para demais formas de fotografia - fotos artísticas ou fotos buscando evidenciar anatomia e/ou texturas dentárias - é possível ',
                  ),
                  TextSpan(
                    text: 'variar a intensidade e direção da iluminação',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: ' para obter diferentes resultados.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

