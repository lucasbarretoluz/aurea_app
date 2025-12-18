import 'package:flutter/material.dart';

class SemiProfessionalCameraSettingsPage4 extends StatelessWidget {
  const SemiProfessionalCameraSettingsPage4({super.key});

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
                    text: 'Essas demais fontes de luz geralmente ',
                  ),
                  TextSpan(
                    text: 'não possuem potência suficiente',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: ' para iluminar as fotos da câmera quando utilizadas as ',
                  ),
                  TextSpan(
                    text: 'configurações sugeridas',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: ' acima.'),
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
                    text: 'Você terá de experimentar com o seu equipamento e ',
                  ),
                  TextSpan(
                    text: 'buscar a forma que irá funcionar com os aparelhos disponíveis',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: '. Ou, se preferir, utilize aa configurações automáticas do seu equipamento. ',
                  ),
                  TextSpan(
                    text: 'Apague as luzes da sala e feche as janelas para que a iluminação não tenha influência externa',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Sempre lembrando de manter o mesmo padrão para as fotos de cada caso.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

