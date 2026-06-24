import 'dart:math' as math;

import 'package:aurea_app/src/smile_planning/models/line_orientation.dart';
import 'package:aurea_app/src/smile_planning/models/line_transform.dart';
import 'package:flutter/material.dart';

class LineGeometry {
  const LineGeometry._();

  static Offset centerPixel(LineTransform transform, Size canvasSize) {
    return Offset(
      transform.offsetX * canvasSize.width,
      transform.offsetY * canvasSize.height,
    );
  }

  static double lineLengthPixels(
    LineTransform transform,
    Size canvasSize,
    LineOrientation orientation,
  ) {
    final base =
        orientation == LineOrientation.vertical
            ? canvasSize.height
            : canvasSize.width;
    return transform.length * base;
  }

  static Offset direction(LineOrientation orientation, double angleRadians) {
    final baseAngle =
        orientation == LineOrientation.vertical
            ? math.pi / 2
            : 0.0;
    final angle = baseAngle + angleRadians;
    return Offset(math.cos(angle), math.sin(angle));
  }

  static Offset lineEndpoint(
    LineTransform transform,
    Size canvasSize,
    LineOrientation orientation, {
    required bool isStart,
  }) {
    final center = centerPixel(transform, canvasSize);
    final halfLength = lineLengthPixels(transform, canvasSize, orientation) / 2;
    final sign = isStart ? -1.0 : 1.0;
    final vector = direction(orientation, transform.angle);
    return center + vector * halfLength * sign;
  }

  static Offset rotationHandlePosition(
    LineTransform transform,
    Size canvasSize,
    LineOrientation orientation,
  ) {
    final end = lineEndpoint(
      transform,
      canvasSize,
      orientation,
      isStart: false,
    );
    final vector = direction(orientation, transform.angle);
    final perpendicular = Offset(-vector.dy, vector.dx);
    return end + perpendicular * 24;
  }

  static LineTransform movedTransform({
    required LineTransform transform,
    required Size canvasSize,
    required Offset deltaPixels,
  }) {
    if (canvasSize.width == 0 || canvasSize.height == 0) {
      return transform;
    }

    return transform.copyWith(
      offsetX: (transform.offsetX * canvasSize.width + deltaPixels.dx) /
          canvasSize.width,
      offsetY: (transform.offsetY * canvasSize.height + deltaPixels.dy) /
          canvasSize.height,
    );
  }

  static LineTransform rotatedTransform({
    required LineTransform transform,
    required Size canvasSize,
    required LineOrientation orientation,
    required Offset centerPixels,
    required Offset handlePixels,
  }) {
    final vector = handlePixels - centerPixels;
    final baseAngle =
        orientation == LineOrientation.vertical ? math.pi / 2 : 0.0;
    final angle = math.atan2(vector.dy, vector.dx) - baseAngle;
    return transform.copyWith(angle: angle);
  }
}
