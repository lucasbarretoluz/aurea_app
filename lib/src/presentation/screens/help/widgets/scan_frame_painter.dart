import 'package:flutter/material.dart';

class ScanFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
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

    /// *****************************************************
    /// Bottom Left Corner
    /// *****************************************************
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

