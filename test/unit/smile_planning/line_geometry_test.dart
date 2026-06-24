import 'package:aurea_app/src/smile_planning/models/line_orientation.dart';
import 'package:aurea_app/src/smile_planning/models/line_transform.dart';
import 'package:aurea_app/src/smile_planning/utils/line_geometry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LineGeometry', () {
    const canvasSize = Size(200, 400);
    const transform = LineTransform(
      offsetX: 0.5,
      offsetY: 0.5,
      angle: 0,
      length: 0.5,
    );

    test('centerPixel maps normalized coordinates', () {
      expect(
        LineGeometry.centerPixel(transform, canvasSize),
        const Offset(100, 200),
      );
    });

    test('lineLengthPixels uses canvas height for vertical lines', () {
      expect(
        LineGeometry.lineLengthPixels(
          transform,
          canvasSize,
          LineOrientation.vertical,
        ),
        200,
      );
    });

    test('movedTransform applies pixel delta', () {
      final moved = LineGeometry.movedTransform(
        transform: transform,
        canvasSize: canvasSize,
        deltaPixels: const Offset(20, 0),
      );

      expect(moved.offsetX, 0.6);
      expect(moved.offsetY, 0.5);
    });
  });
}
