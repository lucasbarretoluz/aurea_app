import 'package:aurea_app/src/smile_planning/models/line_transform.dart';
import 'package:aurea_app/src/smile_planning/models/reference_line.dart';
import 'package:aurea_app/src/smile_planning/models/reference_line_type.dart';
import 'package:aurea_app/src/smile_planning/models/reference_lines.dart';
import 'package:aurea_app/src/smile_planning/utils/reference_line_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ReferenceLineUtils', () {
    test('defaultTransform returns vertical midline defaults', () {
      final transform = ReferenceLineUtils.defaultTransform(
        ReferenceLineType.midline,
      );

      expect(transform.offsetX, 0.5);
      expect(transform.length, 0.85);
    });

    test('resolveTransform returns saved line when present', () {
      const lines = ReferenceLines(
        faceLines: [
          ReferenceLine(
            type: ReferenceLineType.midline,
            phase: CalibrationPhase.face,
            transform: LineTransform(offsetX: 0.42),
          ),
        ],
      );

      final transform = ReferenceLineUtils.resolveTransform(
        referenceLines: lines,
        type: ReferenceLineType.midline,
        phase: CalibrationPhase.face,
      );

      expect(transform.offsetX, 0.42);
    });

    test('buildFaceDisplayedLines includes previous lines as inactive', () {
      const lines = ReferenceLines(
        faceLines: [
          ReferenceLine(
            type: ReferenceLineType.midline,
            phase: CalibrationPhase.face,
            transform: LineTransform(offsetX: 0.4),
          ),
        ],
      );

      final displayed = ReferenceLineUtils.buildFaceDisplayedLines(
        referenceLines: lines,
        activeType: ReferenceLineType.bipupillary,
        activeTransform: const LineTransform(offsetY: 0.4),
      );

      expect(displayed, hasLength(2));
      expect(displayed.first.isActive, isFalse);
      expect(displayed.last.isActive, isTrue);
      expect(displayed.first.transform.offsetX, 0.4);
    });

    test('buildFaceDisplayedLines shows only midline on first line step', () {
      final displayed = ReferenceLineUtils.buildFaceDisplayedLines(
        referenceLines: const ReferenceLines(),
        activeType: ReferenceLineType.midline,
        activeTransform: const LineTransform(),
      );

      expect(displayed, hasLength(1));
      expect(displayed.single.isActive, isTrue);
    });
  });
}
