import 'package:flutter/material.dart';

class CoordinateMapper {
  const CoordinateMapper._();

  static Offset normalizedToPixel(Offset normalized, Size canvasSize) {
    return Offset(
      normalized.dx * canvasSize.width,
      normalized.dy * canvasSize.height,
    );
  }

  static Offset pixelToNormalized(Offset pixel, Size canvasSize) {
    if (canvasSize.width == 0 || canvasSize.height == 0) {
      return Offset.zero;
    }
    return Offset(
      pixel.dx / canvasSize.width,
      pixel.dy / canvasSize.height,
    );
  }

  static Size fittedImageSize({
    required Size imageSize,
    required Size canvasSize,
    BoxFit fit = BoxFit.contain,
  }) {
    if (imageSize.width == 0 || imageSize.height == 0) {
      return Size.zero;
    }

    final widthRatio = canvasSize.width / imageSize.width;
    final heightRatio = canvasSize.height / imageSize.height;

    switch (fit) {
      case BoxFit.contain:
        final scale = widthRatio < heightRatio ? widthRatio : heightRatio;
        return Size(imageSize.width * scale, imageSize.height * scale);
      case BoxFit.cover:
        final scale = widthRatio > heightRatio ? widthRatio : heightRatio;
        return Size(imageSize.width * scale, imageSize.height * scale);
      default:
        return canvasSize;
    }
  }
}
