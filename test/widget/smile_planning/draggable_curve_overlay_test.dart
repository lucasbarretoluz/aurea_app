import 'package:aurea_app/src/smile_planning/models/curve_data.dart';
import 'package:aurea_app/src/smile_planning/models/normalized_point.dart';
import 'package:aurea_app/src/smile_planning/widgets/draggable_curve_overlay.dart';
import 'package:aurea_app/src/smile_planning/widgets/line_handle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DraggableCurveOverlay', () {
    const canvasSize = Size(300, 300);

    testWidgets('renders control point handles', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DraggableCurveOverlay(
              canvasSize: canvasSize,
              curve: const CurveData(
                controlPoints: [
                  NormalizedPoint(x: 0.2, y: 0.5),
                  NormalizedPoint(x: 0.5, y: 0.4),
                  NormalizedPoint(x: 0.8, y: 0.5),
                ],
              ),
              onCurveChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(LineHandle), findsNWidgets(3));
    });

    testWidgets('dragging control point updates curve', (
      WidgetTester tester,
    ) async {
      CurveData? latestCurve;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DraggableCurveOverlay(
              canvasSize: canvasSize,
              curve: const CurveData(
                controlPoints: [
                  NormalizedPoint(x: 0.2, y: 0.5),
                  NormalizedPoint(x: 0.5, y: 0.4),
                  NormalizedPoint(x: 0.8, y: 0.5),
                ],
              ),
              onCurveChanged: (value) => latestCurve = value,
            ),
          ),
        ),
      );

      await tester.drag(find.byType(LineHandle).first, const Offset(0, -40));
      await tester.pump();

      expect(latestCurve, isNotNull);
      expect(latestCurve!.controlPoints.first.y, lessThan(0.5));
    });
  });
}
