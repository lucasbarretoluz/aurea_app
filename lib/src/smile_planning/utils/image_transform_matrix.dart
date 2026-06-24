import 'package:aurea_app/src/smile_planning/models/image_transform.dart';
import 'package:flutter/material.dart';

class ImageTransformMatrix {
  const ImageTransformMatrix._();

  static Matrix4 toMatrix(ImageTransform transform, Size viewport) {
    final dx = transform.offsetX * viewport.width;
    final dy = transform.offsetY * viewport.height;
    final matrix = Matrix4.identity()..setTranslationRaw(dx, dy, 0);
    matrix.scaleByDouble(transform.scale, transform.scale, 1, 1);
    return matrix;
  }
}
