import 'package:aurea_app/src/smile_planning/models/line_orientation.dart';
import 'package:aurea_app/src/smile_planning/models/line_transform.dart';
import 'package:aurea_app/src/smile_planning/utils/line_geometry.dart';
import 'package:aurea_app/src/smile_planning/widgets/line_handle.dart';
import 'package:aurea_app/src/smile_planning/widgets/reference_line_painter.dart';
import 'package:flutter/material.dart';

class DisplayedReferenceLine {
  final LineTransform transform;
  final LineOrientation orientation;
  final bool isActive;

  const DisplayedReferenceLine({
    required this.transform,
    required this.orientation,
    this.isActive = false,
  });
}

class DraggableLineOverlay extends StatefulWidget {
  final Size canvasSize;
  final List<DisplayedReferenceLine> lines;
  final int activeIndex;
  final ValueChanged<LineTransform> onTransformChanged;

  const DraggableLineOverlay({
    super.key,
    required this.canvasSize,
    required this.lines,
    required this.activeIndex,
    required this.onTransformChanged,
  });

  @override
  State<DraggableLineOverlay> createState() => _DraggableLineOverlayState();
}

class _DraggableLineOverlayState extends State<DraggableLineOverlay> {
  LineTransform? _dragStartTransform;

  DisplayedReferenceLine? get _activeLine {
    if (widget.activeIndex < 0 || widget.activeIndex >= widget.lines.length) {
      return null;
    }
    return widget.lines[widget.activeIndex];
  }

  void _onMoveUpdate(DragUpdateDetails details) {
    final active = _activeLine;
    final startTransform = _dragStartTransform;
    if (active == null || startTransform == null) return;

    final updated = LineGeometry.movedTransform(
      transform: startTransform,
      canvasSize: widget.canvasSize,
      deltaPixels: details.delta,
    );
    widget.onTransformChanged(updated);
  }

  void _onRotateUpdate(DragUpdateDetails details) {
    final active = _activeLine;
    if (active == null) return;

    final center = LineGeometry.centerPixel(active.transform, widget.canvasSize);
    final updated = LineGeometry.rotatedTransform(
      transform: active.transform,
      canvasSize: widget.canvasSize,
      orientation: active.orientation,
      centerPixels: center,
      handlePixels: center + details.delta,
    );
    widget.onTransformChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    final active = _activeLine;

    return SizedBox(
      width: widget.canvasSize.width,
      height: widget.canvasSize.height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (var i = 0; i < widget.lines.length; i++)
            CustomPaint(
              size: widget.canvasSize,
              painter: ReferenceLinePainter(
                transform: widget.lines[i].transform,
                orientation: widget.lines[i].orientation,
                color:
                    widget.lines[i].isActive
                        ? Colors.black
                        : Colors.grey.shade400,
                strokeWidth: widget.lines[i].isActive ? 2.5 : 1.5,
              ),
            ),
          if (active != null) ...[
            Positioned(
              left:
                  LineGeometry.centerPixel(active.transform, widget.canvasSize)
                      .dx -
                  18,
              top:
                  LineGeometry.centerPixel(active.transform, widget.canvasSize)
                      .dy -
                  18,
              child: LineHandle(
                icon: Icons.open_with,
                onPanStart: () {
                  _dragStartTransform = active.transform;
                },
                onPanUpdate: _onMoveUpdate,
                onPanEnd: () => _dragStartTransform = null,
              ),
            ),
            Positioned(
              left:
                  LineGeometry.rotationHandlePosition(
                        active.transform,
                        widget.canvasSize,
                        active.orientation,
                      )
                      .dx -
                  18,
              top:
                  LineGeometry.rotationHandlePosition(
                        active.transform,
                        widget.canvasSize,
                        active.orientation,
                      )
                      .dy -
                  18,
              child: LineHandle(
                icon: Icons.rotate_right,
                onPanUpdate: _onRotateUpdate,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
