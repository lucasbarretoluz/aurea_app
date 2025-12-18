import 'package:flutter/material.dart';

class SemiProfessionalCameraSettingsPage1 extends StatelessWidget {
  const SemiProfessionalCameraSettingsPage1({super.key});

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
                    text: 'Além da qualidade do seu equipamento, o fator que mais vai influenciar o resultado das suas fotos é a ',
                  ),
                  TextSpan(
                    text: 'iluminação',
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
                    text: 'As configurações da sua câmera devem buscar ',
                  ),
                  TextSpan(
                    text: 'bloquear quaisquer influências da iluminação ambiente',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: ' nas fotos, capturando somente as áreas iluminadas pelo flash da câmera. Porém, para que essa estratégia seja efetiva, o ',
                  ),
                  TextSpan(
                    text: 'flash deve ter uma potência suficiente para iluminar a área de interesse',
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
                    text: 'Dessa forma, suas fotos serão sempre influenciadas pelo mesmo padrão de luz, mantendo-as ',
                  ),
                  TextSpan(
                    text: 'padronizadas e com credibilidade profissional',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

