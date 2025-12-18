import 'package:flutter/material.dart';

class PhotographingWithCellphonePage3 extends StatelessWidget {
  const PhotographingWithCellphonePage3({super.key});

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
                text: 'Quando a câmera do smartphone for do tipo grande angular, ao fotografar sem ampliar o zoom, ocorre o chamado ',
              ),
              const TextSpan(
                text: '"efeito barril"',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              const TextSpan(
                text: '. Há uma ',
              ),
              TextSpan(
                text: 'distorção nas extremidades da foto',
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
                text: 'O segredo é se ',
              ),
              TextSpan(
                text: 'afastar',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: ' um pouco do paciente e ',
              ),
              TextSpan(
                text: 'ampliar levemente o zoom',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: ' da fotografia. Assim ela ficará mais fiel à realidade.',
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
                text: 'Porém, você deve cuidar para ',
              ),
              TextSpan(
                text: 'não entrar no modo de zoom digital da câmera',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: '. Atente-se para permanecer na faixa de ',
              ),
              TextSpan(
                text: 'zoom óptico',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: ' da câmera do seu celular. Ao entrar no zoom digital, você ',
              ),
              TextSpan(
                text: 'perderá qualidade e definição da imagem',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: '.'),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Pesquise, de acordo com o modelo do seu aparelho, as medições exatas.',
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

