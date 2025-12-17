import 'dart:math' as math;

import 'package:aurea_app/src/presentation/widgets/buttons/navigation_buttons.dart';
import 'package:aurea_app/src/presentation/widgets/containers/shadow_gradient_container.dart';
import 'package:flutter/material.dart';

class PhotographicProtocolPage14 extends StatelessWidget {
  final int currentPage;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final Color colorGradient;

  const PhotographicProtocolPage14({
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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(text: 'Posicionar a\ncâmera '),
                        TextSpan(
                          text: 'muito\nacima',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(text: ' do plano\noclusal resultará\nem um '),
                        TextSpan(
                          text: 'sorriso\nexagerado',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(text: ' na\nfotografia.'),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/smile.png'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IgnorePointer(
                  child: CustomPaint(
                    size: const Size(170, 200),
                    painter: _SideArrowPainter(),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Image.asset('assets/images/mannequin_retractor.png'),
                ),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ShadowGradientContainer(
            borderRadius: null,
            disableShadow: true,
            height: 200,
            colorGradient: colorGradient,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Column(
                  children: [
                    const Text(
                      'Posição da câmera em ',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    const Text(
                      'relação ao paciente',
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
            onPrevious: onPrevious,
            onNext: onNext,
          ),
        ),
      ],
    );
  }
}



class _SideArrowPainter extends CustomPainter {
  const _SideArrowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final whitePaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0
          ..strokeCap = StrokeCap.round;

    final redPaint =
        Paint()
          ..color = const Color(0xFFE53935)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5.0
          ..strokeCap = StrokeCap.round;

    final end = Offset(size.width * 0.9, size.height * 0.62);
    const whiteLineYOffset = 14.0;
    final horizontalStart = Offset(size.width * 0.05, end.dy + whiteLineYOffset);
    final horizontalEnd = Offset(end.dx, end.dy + whiteLineYOffset);
    canvas.drawLine(horizontalStart, horizontalEnd, whitePaint);

    final arrowStart = Offset(size.width * 0.1, size.height * 0.15);
    canvas.drawLine(arrowStart, end, redPaint);

    final direction = (end - arrowStart);
    final length = direction.distance;
    if (length == 0) return;

    final unit = direction / length;
    const headLength = 16.0;
    const headAngle = 0.8;

    final left = Offset(
      unit.dx * math.cos(headAngle) - unit.dy * math.sin(headAngle),
      unit.dx * math.sin(headAngle) + unit.dy * math.cos(headAngle),
    );
    final right = Offset(
      unit.dx * math.cos(-headAngle) - unit.dy * math.sin(-headAngle),
      unit.dx * math.sin(-headAngle) + unit.dy * math.cos(-headAngle),
    );

    canvas.drawLine(end, end - left * headLength, redPaint);
    canvas.drawLine(end, end - right * headLength, redPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}



