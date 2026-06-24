import 'package:aurea_app/src/smile_planning/models/image_transform.dart';
import 'package:aurea_app/src/smile_planning/utils/coordinate_mapper.dart';
import 'package:aurea_app/src/smile_planning/utils/image_transform_matrix.dart';
import 'package:aurea_app/src/smile_planning/widgets/image_pan_zoom_view.dart';
import 'package:flutter/material.dart';

class SmileCanvas extends StatefulWidget {
  final ImageProvider imageProvider;
  final Widget? overlay;
  final ValueChanged<Size>? onCanvasSizeChanged;
  final bool enablePanZoom;
  final ImageTransform? panZoomTransform;
  final ValueChanged<ImageTransform>? onPanZoomChanged;
  final ImageTransform? frozenImageTransform;

  const SmileCanvas({
    super.key,
    required this.imageProvider,
    this.overlay,
    this.onCanvasSizeChanged,
    this.enablePanZoom = false,
    this.panZoomTransform,
    this.onPanZoomChanged,
    this.frozenImageTransform,
  });

  @override
  State<SmileCanvas> createState() => _SmileCanvasState();
}

class _SmileCanvasState extends State<SmileCanvas> {
  Size? _renderedImageSize;
  Size? _canvasSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final canvasSize = Size(constraints.maxWidth, constraints.maxHeight);
        _canvasSize = canvasSize;

        Widget content = Stack(
          fit: StackFit.expand,
          children: [
            if (widget.enablePanZoom)
              ImagePanZoomView(
                imageProvider: widget.imageProvider,
                transform: widget.panZoomTransform ?? const ImageTransform(),
                onTransformChanged: widget.onPanZoomChanged ?? (_) {},
              )
            else
              Image(
                image: widget.imageProvider,
                fit: BoxFit.contain,
                frameBuilder: (
                  context,
                  child,
                  frame,
                  wasSynchronouslyLoaded,
                ) {
                  if (wasSynchronouslyLoaded || frame != null) {
                    return child;
                  }
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.broken_image_outlined,
                      size: 64,
                      color: Colors.grey.shade500,
                    ),
                  );
                },
              ),
            if (widget.overlay != null)
              if (widget.enablePanZoom)
                Positioned.fill(child: widget.overlay!)
              else if (_renderedImageSize != null)
                Center(
                  child: SizedBox(
                    width: _renderedImageSize!.width,
                    height: _renderedImageSize!.height,
                    child: widget.overlay,
                  ),
                ),
          ],
        );

        final frozenTransform = widget.frozenImageTransform;
        if (!widget.enablePanZoom &&
            frozenTransform != null &&
            frozenTransform != const ImageTransform()) {
          content = Transform(
            transform: ImageTransformMatrix.toMatrix(frozenTransform, canvasSize),
            alignment: Alignment.center,
            child: content,
          );
        }

        return Container(
          color: const Color(0xFFF0F0F0),
          child: Center(
            child: SizedBox(
              width: canvasSize.width,
              height: canvasSize.height,
              child: content,
            ),
          ),
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!widget.enablePanZoom) {
      _resolveImageSize();
    }
  }

  @override
  void didUpdateWidget(SmileCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.enablePanZoom &&
        oldWidget.imageProvider != widget.imageProvider) {
      _resolveImageSize();
    }
  }

  Future<void> _resolveImageSize() async {
    final stream = widget.imageProvider.resolve(const ImageConfiguration());
    stream.addListener(
      ImageStreamListener((info, _) {
        final imageSize = Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        );
        if (!mounted) return;
        final box = context.findRenderObject() as RenderBox?;
        final canvas = _canvasSize ?? box?.size;
        if (canvas == null || canvas.width == 0) return;

        final fitted = CoordinateMapper.fittedImageSize(
          imageSize: imageSize,
          canvasSize: canvas,
        );
        setState(() => _renderedImageSize = fitted);
        widget.onCanvasSizeChanged?.call(fitted);
      }),
    );
  }
}
