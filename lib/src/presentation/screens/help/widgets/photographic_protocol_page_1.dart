import 'dart:ui';

import 'package:aurea_app/src/presentation/widgets/buttons/navigation_buttons.dart';
import 'package:aurea_app/src/presentation/widgets/containers/shadow_gradient_container.dart';
import 'package:flutter/material.dart';

class PhotographicProtocolPage1 extends StatelessWidget {
  final int currentPage;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final Color colorGradient;

  const PhotographicProtocolPage1({
    super.key,
    required this.currentPage,
    required this.onPrevious,
    required this.onNext,
    required this.colorGradient,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 90,
          child: Transform.scale(
            scale: 1.25,
            child: Image.asset(
              'assets/images/mannequin_male_front.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          left: 30,
          right: 30,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 420,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 30,
          right: 30,
          child: Container(
            height: 420,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colorGradient.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    const Text(
                      'Atenção',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        letterSpacing: 3.5,
                      ),
                    ),
                    Container(
                      height: 2,
                      width: 150,
                      color: Colors.black,
                      margin: const EdgeInsets.only(bottom: 16),
                    ),
                  ],
                ),
                Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          height: 1.5,
                          fontFamily: 'Montserrat',
                        ),
                        children: [
                          TextSpan(
                            text:
                                'A etapa mais importante do registro fotográfico dos seus casos é a ',
                          ),
                          TextSpan(
                            text: 'padronização',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          height: 1.5,
                          fontFamily: 'Montserrat',
                        ),
                        children: [
                          TextSpan(
                            text:
                                'Não importa qual equipamento você esteja utilizando: mantenha as mesmas ',
                          ),
                          TextSpan(
                            text: 'configurações',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: ', '),
                          TextSpan(
                            text: 'ângulos',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: ', '),
                          TextSpan(
                            text: 'iluminação',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: ' e '),
                          TextSpan(
                            text: 'enquadramento',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: ' em todas as etapas do tratamento.'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ShadowGradientContainer(
            height: 230,
            colorGradient: colorGradient,
            child: SizedBox(),
          ),
        ),
        Positioned(
          bottom: 50,
          left: 0,
          right: 0,
          child: NavigationButtons(
            currentPage: currentPage,
            onPrevious: onPrevious,
            onNext: onNext,
          ),
        ),
      ],
    );
  }
}
