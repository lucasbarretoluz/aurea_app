import 'package:flutter/material.dart';

class PhotographingWithCellphonePage2 extends StatelessWidget {
  const PhotographingWithCellphonePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'É possível atingir esse resultado utilizando mais de uma fonte de luz (como luzes de LED portáteis) ou uma fonte de luz circular (como um ring light).',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            height: 1.5,
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
                text: 'Utilize uma fonte externa de luz com as ',
              ),
              TextSpan(
                text: 'luzes da sala apagadas',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: ' e as ',
              ),
              TextSpan(
                text: 'janelas fechadas',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: '. Dessa forma, suas fotos serão ',
              ),
              TextSpan(
                text: 'sempre influenciadas',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: 'pelo mesmo padrão de luz',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: ', mantendo-as padronizadas e com credibilidade profissional.',
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
                text: 'Existem outros dois detalhes que devem ser levados em consideração ao fotografar utilizando o celular para evitar ',
              ),
              TextSpan(
                text: 'distorções',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: ' ou ',
              ),
              TextSpan(
                text: 'perda de',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: 'qualidade',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: ' das fotos odontológicas.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

