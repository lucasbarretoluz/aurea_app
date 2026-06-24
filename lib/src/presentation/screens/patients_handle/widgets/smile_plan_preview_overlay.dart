import 'package:aurea_app/src/smile_planning/models/line_orientation.dart';
import 'package:aurea_app/src/smile_planning/models/reference_line.dart';
import 'package:aurea_app/src/smile_planning/models/smile_plan.dart';
import 'package:aurea_app/src/smile_planning/utils/reference_line_utils.dart';
import 'package:aurea_app/src/smile_planning/widgets/draggable_curve_overlay.dart';
import 'package:aurea_app/src/smile_planning/widgets/reference_line_painter.dart';
import 'package:flutter/material.dart';

class SmilePlanPreviewOverlay extends StatelessWidget {
  final SmilePlan plan;

  const SmilePlanPreviewOverlay({super.key, required this.plan});

  LineOrientation _orientation(ReferenceLine line) {
    return line.type.defaultOrientation;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        final faceLines = plan.referenceLines.faceLines;
        final smileLines = plan.referenceLines.smileLines;
        final curve = plan.curve;

        return IgnorePointer(
          child: Stack(
            fit: StackFit.expand,
            children: [
              for (final line in faceLines)
                CustomPaint(
                  size: size,
                  painter: ReferenceLinePainter(
                    transform: line.transform,
                    orientation: _orientation(line),
                    color: Colors.white.withValues(alpha: 0.9),
                    strokeWidth: 2,
                  ),
                ),
              for (final line in smileLines)
                CustomPaint(
                  size: size,
                  painter: ReferenceLinePainter(
                    transform: line.transform,
                    orientation: _orientation(line),
                    color: Colors.white.withValues(alpha: 0.9),
                    strokeWidth: 2,
                  ),
                ),
              if (curve != null && curve.controlPoints.length >= 2)
                CustomPaint(
                  size: size,
                  painter: SmileCurvePainter(
                    controlPoints: curve.controlPoints,
                    color: Colors.white.withValues(alpha: 0.9),
                    strokeWidth: 2,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
