import 'dart:math' as math;

import 'package:aurea_app/src/smile_planning/models/curve_data.dart';
import 'package:aurea_app/src/smile_planning/models/normalized_point.dart';
import 'package:aurea_app/src/smile_planning/utils/coordinate_mapper.dart';
import 'package:aurea_app/src/smile_planning/widgets/line_handle.dart';
import 'package:flutter/material.dart';

class SmileCurvePainter extends CustomPainter {
  final List<NormalizedPoint> controlPoints;
  final Color color;
  final double strokeWidth;

  SmileCurvePainter({
    required this.controlPoints,
    required this.color,
    this.strokeWidth = 2.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (controlPoints.length < 2) return;

    final path = Path();
    final first = _toOffset(controlPoints.first, size);
    path.moveTo(first.dx, first.dy);

    if (controlPoints.length == 2) {
      final second = _toOffset(controlPoints[1], size);
      path.lineTo(second.dx, second.dy);
    } else if (controlPoints.length == 3) {
      final control = _toOffset(controlPoints[1], size);
      final end = _toOffset(controlPoints[2], size);
      path.quadraticBezierTo(control.dx, control.dy, end.dx, end.dy);
    } else {
      for (var i = 1; i < controlPoints.length; i++) {
        final current = _toOffset(controlPoints[i], size);
        final previous = _toOffset(controlPoints[i - 1], size);
        final mid = Offset(
          (previous.dx + current.dx) / 2,
          (previous.dy + current.dy) / 2,
        );
        if (i == 1) {
          path.lineTo(mid.dx, mid.dy);
        } else {
          path.quadraticBezierTo(previous.dx, previous.dy, mid.dx, mid.dy);
        }
      }
      final last = _toOffset(controlPoints.last, size);
      final beforeLast = _toOffset(controlPoints[controlPoints.length - 2], size);
      path.quadraticBezierTo(beforeLast.dx, beforeLast.dy, last.dx, last.dy);
    }

    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, paint);
  }

  Offset _toOffset(NormalizedPoint point, Size size) {
    return CoordinateMapper.normalizedToPixel(
      Offset(point.x, point.y),
      size,
    );
  }

  @override
  bool shouldRepaint(covariant SmileCurvePainter oldDelegate) {
    return oldDelegate.controlPoints != controlPoints ||
        oldDelegate.color != color;
  }
}

class DraggableCurveOverlay extends StatefulWidget {
  final Size canvasSize;
  final CurveData? curve;
  final ValueChanged<CurveData> onCurveChanged;
  final Color curveColor;

  const DraggableCurveOverlay({
    super.key,
    required this.canvasSize,
    required this.curve,
    required this.onCurveChanged,
    this.curveColor = Colors.black,
  });

  @override
  State<DraggableCurveOverlay> createState() => _DraggableCurveOverlayState();
}

class _DraggableCurveOverlayState extends State<DraggableCurveOverlay> {
  static const _defaultPoints = [
    NormalizedPoint(x: 0.2, y: 0.55),
    NormalizedPoint(x: 0.5, y: 0.45),
    NormalizedPoint(x: 0.8, y: 0.55),
  ];

  List<NormalizedPoint> get _points {
    final points = widget.curve?.controlPoints ?? const <NormalizedPoint>[];
    if (points.length >= 3) return points;
    return _defaultPoints;
  }

  void _updatePoint(int index, DragUpdateDetails details) {
    if (widget.canvasSize.width == 0 || widget.canvasSize.height == 0) return;

    final points = [..._points];
    final current = points[index];
    final delta = Offset(
      details.delta.dx / widget.canvasSize.width,
      details.delta.dy / widget.canvasSize.height,
    );

    points[index] = NormalizedPoint(
      x: _clamp(current.x + delta.dx),
      y: _clamp(current.y + delta.dy),
    );

    widget.onCurveChanged(CurveData(controlPoints: points));
  }

  double _clamp(double value) => math.max(0, math.min(1, value));

  @override
  Widget build(BuildContext context) {
    final points = _points;

    return SizedBox(
      width: widget.canvasSize.width,
      height: widget.canvasSize.height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: widget.canvasSize,
            painter: SmileCurvePainter(
              controlPoints: points,
              color: widget.curveColor,
            ),
          ),
          for (var i = 0; i < points.length; i++)
            Positioned(
              left:
                  CoordinateMapper.normalizedToPixel(
                    Offset(points[i].x, points[i].y),
                    widget.canvasSize,
                  ).dx -
                  18,
              top:
                  CoordinateMapper.normalizedToPixel(
                    Offset(points[i].x, points[i].y),
                    widget.canvasSize,
                  ).dy -
                  18,
              child: LineHandle(
                icon: Icons.circle,
                onPanUpdate: (details) => _updatePoint(i, details),
              ),
            ),
        ],
      ),
    );
  }
}
