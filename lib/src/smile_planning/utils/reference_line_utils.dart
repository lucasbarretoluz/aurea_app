import 'package:aurea_app/src/smile_planning/models/line_orientation.dart';
import 'package:aurea_app/src/smile_planning/models/line_transform.dart';
import 'package:aurea_app/src/smile_planning/models/reference_line_type.dart';
import 'package:aurea_app/src/smile_planning/models/reference_lines.dart';
import 'package:aurea_app/src/smile_planning/widgets/draggable_line_overlay.dart';

extension ReferenceLineTypeLayout on ReferenceLineType {
  LineOrientation get defaultOrientation {
    switch (this) {
      case ReferenceLineType.midline:
        return LineOrientation.vertical;
      case ReferenceLineType.bipupillary:
      case ReferenceLineType.highSmileLine:
      case ReferenceLineType.smileCurve:
        return LineOrientation.horizontal;
    }
  }
}

const faceCalibrationLineOrder = [
  ReferenceLineType.midline,
  ReferenceLineType.bipupillary,
  ReferenceLineType.highSmileLine,
];

class ReferenceLineUtils {
  const ReferenceLineUtils._();

  static LineTransform defaultTransform(ReferenceLineType type) {
    switch (type) {
      case ReferenceLineType.midline:
        return const LineTransform(
          offsetX: 0.5,
          offsetY: 0.5,
          length: 0.85,
        );
      case ReferenceLineType.bipupillary:
        return const LineTransform(
          offsetX: 0.5,
          offsetY: 0.38,
          length: 0.7,
        );
      case ReferenceLineType.highSmileLine:
        return const LineTransform(
          offsetX: 0.5,
          offsetY: 0.62,
          length: 0.55,
        );
      case ReferenceLineType.smileCurve:
        return const LineTransform(
          offsetX: 0.5,
          offsetY: 0.55,
          length: 0.6,
        );
    }
  }

  static LineTransform resolveTransform({
    required ReferenceLines referenceLines,
    required ReferenceLineType type,
    required CalibrationPhase phase,
  }) {
    final collection =
        phase == CalibrationPhase.face
            ? referenceLines.faceLines
            : referenceLines.smileLines;

    for (final line in collection) {
      if (line.type == type) return line.transform;
    }

    return defaultTransform(type);
  }

  static List<DisplayedReferenceLine> buildFaceDisplayedLines({
    required ReferenceLines referenceLines,
    required ReferenceLineType activeType,
    required LineTransform activeTransform,
  }) {
    final activeIndex = faceCalibrationLineOrder.indexOf(activeType);
    if (activeIndex < 0) return const [];

    final lines = <DisplayedReferenceLine>[];
    for (var i = 0; i <= activeIndex; i++) {
      final type = faceCalibrationLineOrder[i];
      final isActive = type == activeType;
      lines.add(
        DisplayedReferenceLine(
          transform:
              isActive
                  ? activeTransform
                  : resolveTransform(
                    referenceLines: referenceLines,
                    type: type,
                    phase: CalibrationPhase.face,
                  ),
          orientation: type.defaultOrientation,
          isActive: isActive,
        ),
      );
    }
    return lines;
  }
}
