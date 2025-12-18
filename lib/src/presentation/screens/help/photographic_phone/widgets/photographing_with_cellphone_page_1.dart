import 'package:flutter/material.dart';

class PhotographingWithCellphonePage1 extends StatelessWidget {
  const PhotographingWithCellphonePage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                text: 'Se você não possui uma câmera semiprofissional, saiba que é possível ',
              ),
              TextSpan(
                text: 'fazer boas fotografias odontológicas utilizando o seu smartphone',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: '. Tudo vai depender da qualidade da câmera e de outros equipamentos complementares, como a ',
              ),
              TextSpan(
                text: 'iluminação artificial',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: '.'),
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
                text: 'A iluminação ambiente ou do ',
              ),
              TextSpan(
                text: 'refletor não é uma boa escolha',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: ', pois pode sofrer alterações de acordo com o horário e/ou clima de cada dia.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'O melhor padrão de iluminação para as fotografias odontológicas de diagnóstico é um padrão multidirecional - criando a menor quantidade de sombras possível.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

