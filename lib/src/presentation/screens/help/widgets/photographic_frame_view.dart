import 'package:aurea_app/src/presentation/screens/help/widgets/scan_frame_painter.dart';
import 'package:flutter/material.dart';

class PhotographicFrameView extends StatelessWidget {
  final String imageAsset;
  final double imageScale;
  final double? customPaintWidth;
  final double? customPaintHeight;
  final double? gradientTop;
  final double? gradientLeft;
  final double? gradientRight;
  final double? gradientHeight;

  const PhotographicFrameView({
    super.key,
    required this.imageAsset,
    this.imageScale = 1.25,
    this.customPaintWidth = 600,
    this.customPaintHeight = 700,
    this.gradientTop = 310,
    this.gradientLeft = 19,
    this.gradientRight = 19,
    this.gradientHeight = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.scale(
          scale: imageScale,
          child: Image.asset(
            imageAsset,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          top: gradientTop,
          left: gradientLeft,
          right: gradientRight,
          child: Container(
            height: gradientHeight,
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
        if (customPaintWidth != null && customPaintHeight != null)
          CustomPaint(
            size: Size(customPaintWidth!, customPaintHeight!),
            painter: ScanFramePainter(),
          ),
      ],
    );
  }
}

