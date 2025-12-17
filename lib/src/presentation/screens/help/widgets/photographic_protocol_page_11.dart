import 'package:aurea_app/src/presentation/screens/help/widgets/photographic_frame_view.dart';
import 'package:aurea_app/src/presentation/widgets/buttons/navigation_buttons.dart';
import 'package:aurea_app/src/presentation/widgets/containers/shadow_gradient_container.dart';
import 'package:flutter/material.dart';

class PhotographicProtocolPage11 extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final Color colorGradient;

  const PhotographicProtocolPage11({
    super.key,
    required this.currentPage,
    required this.totalPages,
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
          bottom: 100,
          child: PhotographicFrameView(
            imageAsset: 'assets/images/mouth_full_front.png',
            imageScale: 1,
            customPaintWidth: 600,
            customPaintHeight: 700,
            gradientTop: 310,
            gradientLeft: 19,
            gradientRight: 19,
            gradientHeight: 200,
            scanFrameMarginTop: 150.0,
            scanFrameMarginBottom: 230.0,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ShadowGradientContainer(
            borderRadius: null,
            disableShadow: true,
            height: 250,
            colorGradient: colorGradient,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Column(
                  children: [
                    const Text(
                      'Fotografia do Sorriso',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        letterSpacing: 3.5,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 2.5,
                      width: 330,
                      color: Colors.black,
                      margin: const EdgeInsets.only(bottom: 16),
                    ),
                    const Text(
                      'Paciente com afastador de',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    const Text(
                      'frente',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          left: 0,
          right: 0,
          child: NavigationButtons(
            currentPage: currentPage,
            totalPages: totalPages,
            onPrevious: onPrevious,
            onNext: onNext,
          ),
        ),
      ],
    );
  }
}
