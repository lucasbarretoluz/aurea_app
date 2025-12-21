import 'package:aurea_app/src/presentation/widgets/buttons/navigation_buttons.dart';
import 'package:aurea_app/src/presentation/widgets/containers/shadow_gradient_container.dart';
import 'package:flutter/material.dart';

class LinesAndReferencesPage5 extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final Color colorGradient;

  const LinesAndReferencesPage5({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPrevious,
    required this.onNext,
    required this.colorGradient,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Transform.scale(
            scale: 1.0,
            child: Image.asset(
              'assets/images/mouth_front.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.15,
          bottom: screenHeight * 0.32,
          left: 0,
          right: 0,
          child: Center(child: Container(width: 2, color: Colors.white)),
        ),
        Positioned(
          top: screenHeight * 0.445,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              height: 2,
              width: screenWidth * 0.8,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.41,
          left: 0,
          right: 0,
          height: screenHeight * 0.15,
          child: CustomPaint(
            painter: _CurvedLinePainter(),
            size: Size(screenWidth, screenHeight * 0.15),
          ),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ShadowGradientContainer(
            height: 250,
            disableShadow: true,
            colorGradient: colorGradient,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Curva do Sorriso',
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
                      width: 220,
                      color: Colors.black,
                      margin: const EdgeInsets.only(bottom: 16),
                    ),
                    const Text(
                      'Linha curvada acompanhando as \nincisais dos dentes superiores',
                      textAlign: TextAlign.center,
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

class _CurvedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final width = size.width * 0.99;
    final height = size.height * 0.5;

    path.moveTo(centerX - width / 2, centerY);
    
    path.quadraticBezierTo(
      centerX,
      centerY + height,
      centerX + width / 2,
      centerY,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
