import 'package:aurea_app/src/smile_planning/models/line_orientation.dart';
import 'package:aurea_app/src/smile_planning/models/line_transform.dart';
import 'package:aurea_app/src/smile_planning/widgets/draggable_line_overlay.dart';
import 'package:aurea_app/src/smile_planning/widgets/line_handle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DraggableLineOverlay', () {
    const canvasSize = Size(300, 400);
    const initialTransform = LineTransform(
      offsetX: 0.5,
      offsetY: 0.5,
      angle: 0,
      length: 0.6,
    );

    testWidgets('renders move and rotation handles for active line', (
      WidgetTester tester,
    ) async {
      var latestTransform = initialTransform;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DraggableLineOverlay(
              canvasSize: canvasSize,
              lines: const [
                DisplayedReferenceLine(
                  transform: initialTransform,
                  orientation: LineOrientation.vertical,
                  isActive: true,
                ),
              ],
              activeIndex: 0,
              onTransformChanged: (value) => latestTransform = value,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.open_with), findsOneWidget);
      expect(find.byIcon(Icons.rotate_right), findsOneWidget);
      expect(find.byType(LineHandle), findsNWidgets(2));

      await tester.drag(find.byIcon(Icons.open_with), const Offset(30, 0));
      await tester.pump();

      expect(latestTransform.offsetX, greaterThan(initialTransform.offsetX));
    });

    testWidgets('renders inactive lines without handles', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DraggableLineOverlay(
              canvasSize: canvasSize,
              lines: [
                DisplayedReferenceLine(
                  transform: LineTransform(
                    offsetX: 0.5,
                    offsetY: 0.3,
                    length: 0.5,
                  ),
                  orientation: LineOrientation.horizontal,
                  isActive: false,
                ),
                DisplayedReferenceLine(
                  transform: initialTransform,
                  orientation: LineOrientation.vertical,
                  isActive: true,
                ),
              ],
              activeIndex: 1,
              onTransformChanged: _noop,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.open_with), findsOneWidget);
      expect(find.byType(CustomPaint), findsWidgets);
    });
  });
}

void _noop(LineTransform _) {}
