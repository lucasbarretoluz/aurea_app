import 'dart:math' as math;

import 'package:aurea_app/src/presentation/widgets/buttons/navigation_buttons.dart';
import 'package:aurea_app/src/presentation/widgets/containers/shadow_gradient_container.dart';
import 'package:flutter/material.dart';

class PhotographicProtocolPage13 extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final Color colorGradient;

  const PhotographicProtocolPage13({
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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Importante!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 4,
                    width: 160,
                    color: Color(0xFFB4DCE5),
                    margin: const EdgeInsets.only(bottom: 16),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 200,
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: 'Fotografe o sorriso do paciente em um ',
                          ),
                          TextSpan(
                            text: 'ângulo de 12º do plano oclusal.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: double.infinity),
                ],
              ),
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
            totalPages: totalPages,
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
          ..strokeWidth = 2.5
          ..strokeCap = StrokeCap.round;

    final redPaint =
        Paint()
          ..color = Color(0xFFB4DCE5)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.5
          ..strokeCap = StrokeCap.round;

    final end = Offset(size.width * 0.9, size.height * 0.62);
    const whiteLineYOffset = 14.0;
    final horizontalStart = Offset(
      size.width * 0.09,
      end.dy + whiteLineYOffset,
    );
    final horizontalEnd = Offset(end.dx, end.dy + whiteLineYOffset);
    canvas.drawLine(horizontalStart, horizontalEnd, whitePaint);

    const arrowAngle = 14 * math.pi / 180;
    final arrowUnit = Offset(math.cos(arrowAngle), math.sin(arrowAngle));
    final arrowStartX = size.width * 0.08;
    final arrowLength = (end.dx - arrowStartX) / arrowUnit.dx;
    final arrowStart = end - arrowUnit * arrowLength;
    canvas.drawLine(arrowStart, end, redPaint);

    final angleText = '12°';
    final textPainter = TextPainter(
      text: TextSpan(
        text: angleText,
        style: TextStyle(
          color: redPaint.color,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontFamily: 'Montserrat',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final textOffset = Offset(
      (horizontalStart.dx + arrowStart.dx) / 2 - textPainter.width / 2 + 10,
      (horizontalStart.dy + arrowStart.dy) / 2 - textPainter.height / 2,
    );
    textPainter.paint(canvas, textOffset);

    final direction = (end - arrowStart);
    final length = direction.distance;
    if (length == 0) return;

    final unit = direction / length;
    const headLength = 13.0;
    const headAngle = 0.4;

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
