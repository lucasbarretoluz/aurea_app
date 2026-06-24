import 'package:aurea_app/src/smile_planning/utils/coordinate_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CoordinateMapper', () {
    test('normalizedToPixel converts coordinates', () {
      const canvasSize = Size(200, 100);
      const normalized = Offset(0.5, 0.25);

      expect(
        CoordinateMapper.normalizedToPixel(normalized, canvasSize),
        const Offset(100, 25),
      );
    });

    test('pixelToNormalized converts coordinates', () {
      const canvasSize = Size(200, 100);
      const pixel = Offset(100, 25);

      expect(
        CoordinateMapper.pixelToNormalized(pixel, canvasSize),
        const Offset(0.5, 0.25),
      );
    });

    test('pixelToNormalized returns zero for empty canvas', () {
      expect(
        CoordinateMapper.pixelToNormalized(const Offset(10, 10), Size.zero),
        Offset.zero,
      );
    });

    test('fittedImageSize uses contain fit', () {
      const imageSize = Size(400, 200);
      const canvasSize = Size(200, 200);

      expect(
        CoordinateMapper.fittedImageSize(
          imageSize: imageSize,
          canvasSize: canvasSize,
        ),
        const Size(200, 100),
      );
    });

    test('fittedImageSize returns zero for empty image', () {
      expect(
        CoordinateMapper.fittedImageSize(
          imageSize: Size.zero,
          canvasSize: const Size(200, 200),
        ),
        Size.zero,
      );
    });
  });
}
