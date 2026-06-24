import 'package:aurea_app/src/smile_planning/models/image_transform.dart';
import 'package:aurea_app/src/smile_planning/utils/image_transform_matrix.dart';
import 'package:flutter/material.dart';

class ImagePanZoomView extends StatefulWidget {
  final ImageProvider imageProvider;
  final ImageTransform transform;
  final ValueChanged<ImageTransform> onTransformChanged;
  final double minScale;
  final double maxScale;

  const ImagePanZoomView({
    super.key,
    required this.imageProvider,
    required this.transform,
    required this.onTransformChanged,
    this.minScale = 0.5,
    this.maxScale = 4.0,
  });

  @override
  State<ImagePanZoomView> createState() => ImagePanZoomViewState();
}

class ImagePanZoomViewState extends State<ImagePanZoomView> {
  final TransformationController _controller = TransformationController();
  Size? _viewportSize;
  bool _isApplyingExternalTransform = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleTransformChanged);
  }

  @override
  void didUpdateWidget(ImagePanZoomView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.transform != widget.transform) {
      _applyTransform(widget.transform);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTransformChanged);
    _controller.dispose();
    super.dispose();
  }

  void resetTransform() {
    _applyTransform(const ImageTransform());
    widget.onTransformChanged(const ImageTransform());
  }

  void _applyTransform(ImageTransform transform) {
    if (_viewportSize == null) return;

    _isApplyingExternalTransform = true;
    _controller.value = _matrixFromTransform(transform, _viewportSize!);
    _isApplyingExternalTransform = false;
  }

  void _handleTransformChanged() {
    if (_isApplyingExternalTransform || _viewportSize == null) return;

    widget.onTransformChanged(
      _transformFromMatrix(_controller.value, _viewportSize!),
    );
  }

  Matrix4 _matrixFromTransform(ImageTransform transform, Size viewport) {
    return ImageTransformMatrix.toMatrix(transform, viewport);
  }

  ImageTransform _transformFromMatrix(Matrix4 matrix, Size viewport) {
    final scale = matrix.getMaxScaleOnAxis();
    final translation = matrix.getTranslation();
    return ImageTransform(
      scale: scale,
      offsetX: viewport.width == 0 ? 0 : translation.x / viewport.width,
      offsetY: viewport.height == 0 ? 0 : translation.y / viewport.height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final viewport = Size(constraints.maxWidth, constraints.maxHeight);
        if (_viewportSize != viewport) {
          _viewportSize = viewport;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) _applyTransform(widget.transform);
          });
        }

        return InteractiveViewer(
          transformationController: _controller,
          minScale: widget.minScale,
          maxScale: widget.maxScale,
          panEnabled: true,
          scaleEnabled: true,
          clipBehavior: Clip.none,
          child: Image(
            image: widget.imageProvider,
            fit: BoxFit.contain,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
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
        );
      },
    );
  }
}
