import 'package:aurea_app/src/presentation/screens/help/widgets/photographic_frame_view.dart';
import 'package:aurea_app/src/presentation/widgets/buttons/navigation_buttons.dart';
import 'package:aurea_app/src/presentation/widgets/containers/shadow_gradient_container.dart';
import 'package:flutter/material.dart';

class PhotographicProtocolPage4 extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final Color colorGradient;

  const PhotographicProtocolPage4({
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
          bottom: 90,
          child: PhotographicFrameView(
            imageAsset: 'assets/images/mannequin_smile_front.png',
            imageScale: 1.25,
            customPaintWidth: 600,
            customPaintHeight: 700,
            gradientTop: 310,
            gradientLeft: 19,
            gradientRight: 19,
            gradientHeight: 200,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ShadowGradientContainer(
            height: 230,
            colorGradient: colorGradient,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const Text(
                      'Fotografia Frontal',
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
                      width: 280,
                      color: Colors.black,
                      margin: const EdgeInsets.only(bottom: 16),
                    ),
                    const Text(
                      'Paciente de frente ',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    const Text(
                      'sorrindo',
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

