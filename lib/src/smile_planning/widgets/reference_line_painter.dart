import 'package:aurea_app/src/smile_planning/models/line_orientation.dart';
import 'package:aurea_app/src/smile_planning/models/line_transform.dart';
import 'package:aurea_app/src/smile_planning/utils/line_geometry.dart';
import 'package:flutter/material.dart';

class ReferenceLinePainter extends CustomPainter {
  final LineTransform transform;
  final LineOrientation orientation;
  final Color color;
  final double strokeWidth;

  ReferenceLinePainter({
    required this.transform,
    required this.orientation,
    required this.color,
    this.strokeWidth = 2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final start = LineGeometry.lineEndpoint(
      transform,
      size,
      orientation,
      isStart: true,
    );
    final end = LineGeometry.lineEndpoint(
      transform,
      size,
      orientation,
      isStart: false,
    );

    final paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant ReferenceLinePainter oldDelegate) {
    return oldDelegate.transform != transform ||
        oldDelegate.orientation != orientation ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
