import 'package:aurea_app/src/presentation/widgets/buttons/navigation_buttons.dart';
import 'package:aurea_app/src/presentation/widgets/containers/shadow_gradient_container.dart';
import 'package:flutter/material.dart';

class PhotographicProtocolPage3 extends StatelessWidget {
  final int currentPage;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final Color colorGradient;

  const PhotographicProtocolPage3({
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
          bottom: 0,
          left: 0,
          right: 0,
          child: ShadowGradientContainer(
            height: 230,
            colorGradient: colorGradient,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavigationButtons(
                  currentPage: currentPage,
                  onPrevious: onPrevious,
                  onNext: onNext,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

