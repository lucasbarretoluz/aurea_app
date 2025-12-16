import 'package:aurea_app/src/presentation/widgets/buttons/navigation_buttons.dart';
import 'package:aurea_app/src/presentation/widgets/containers/shadow_gradient_container.dart';
import 'package:flutter/material.dart';

class PhotographicProtocolPage2 extends StatelessWidget {
  final int currentPage;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final Color colorGradient;

  const PhotographicProtocolPage2({
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform.scale(
                scale: 1.25,
                child: Image.asset(
                  'assets/images/mannequin_female_front.png',
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 310,
                left: 19,
                right: 19,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        const Color(0xFFE0E0E0).withOpacity(0.0),
                        const Color(0xFFE0E0E0).withOpacity(0.1),
                        const Color(0xFFE0E0E0).withOpacity(0.3),
                        const Color(0xFFE0E0E0).withOpacity(0.5),
                      ],
                    ),
                  ),
                ),
              ),
              CustomPaint(size: Size(600, 700), painter: _ScanFramePainter()),
            ],
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
                      'Paciente de frente em ',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    const Text(
                      'repouso',
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

class _ScanFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFFBDBDBD)
          ..strokeWidth = 2.5
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final cornerLength = 80.0;
    final cornerRadius = 15.0;
    final marginHorizontal = 20.0;
    final marginTop = 100.0;
    final marginBottom = 220.0;

    final topLeft = Offset(marginHorizontal, marginTop);
    final topRight = Offset(size.width - marginHorizontal, marginTop);
    final bottomLeft = Offset(marginHorizontal, size.height - marginBottom);
    final bottomRight = Offset(
      size.width - marginHorizontal,
      size.height - marginBottom,
    );

    final path = Path();

    /// *****************************************************
    /// Top Left Corner
    /// *****************************************************
    path.moveTo(topLeft.dx + cornerLength, topLeft.dy);
    path.lineTo(topLeft.dx + cornerRadius, topLeft.dy);

    path.arcToPoint(
      Offset(topLeft.dx, topLeft.dy + cornerRadius),
      radius: Radius.circular(cornerRadius),
      clockwise: false,
    );

    path.lineTo(topLeft.dx, topLeft.dy + cornerLength);

    /// *****************************************************
    /// Top Right Corner
    /// *****************************************************
    path.moveTo(topRight.dx - cornerLength, topRight.dy);
    path.lineTo(topRight.dx - cornerRadius, topRight.dy);

    path.arcToPoint(
      Offset(topRight.dx, topRight.dy + cornerRadius),
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );

    path.lineTo(topRight.dx, topRight.dy + cornerLength);

    // -----------------------------------------------------
    // Bottom Left Corner
    // -----------------------------------------------------
    path.moveTo(bottomLeft.dx + cornerLength, bottomLeft.dy);
    path.lineTo(bottomLeft.dx + cornerRadius, bottomLeft.dy);

    path.arcToPoint(
      Offset(bottomLeft.dx, bottomLeft.dy - cornerRadius),
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );

    path.lineTo(bottomLeft.dx, bottomLeft.dy - cornerLength);

    /// *****************************************************
    /// Bottom Right Corner
    /// *****************************************************
    path.moveTo(bottomRight.dx - cornerLength, bottomRight.dy);
    path.lineTo(bottomRight.dx - cornerRadius, bottomRight.dy);

    path.arcToPoint(
      Offset(bottomRight.dx, bottomRight.dy - cornerRadius),
      radius: Radius.circular(cornerRadius),
      clockwise: false,
    );

    path.lineTo(bottomRight.dx, bottomRight.dy - cornerLength);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
