import 'package:aurea_app/src/smile_planning/models/image_transform.dart';
import 'package:aurea_app/src/smile_planning/models/smile_plan.dart';
import 'package:aurea_app/src/smile_planning/utils/image_transform_matrix.dart';
import 'package:aurea_app/src/presentation/screens/patients_handle/widgets/smile_plan_preview_overlay.dart';
import 'package:aurea_app/src/presentation/screens/patients_handle/widgets/patient_photo_thumbnail_strip.dart';
import 'package:flutter/material.dart';

class PhotoViewer extends StatefulWidget {
  final List<String> photoUrls;
  final VoidCallback onAddPhoto;
  final double? height;
  final ValueChanged<int>? onPageChanged;
  final int initialPage;
  final int? controlledIndex;
  final bool showPlanningPreview;
  final SmilePlan? previewPlan;
  final Set<String> plannedPhotoUrls;

  const PhotoViewer({
    super.key,
    required this.photoUrls,
    required this.onAddPhoto,
    this.height,
    this.onPageChanged,
    this.initialPage = 0,
    this.controlledIndex,
    this.showPlanningPreview = false,
    this.previewPlan,
    this.plannedPhotoUrls = const {},
  });

  @override
  State<PhotoViewer> createState() => PhotoViewerState();
}

class PhotoViewerState extends State<PhotoViewer> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = _clampIndex(widget.controlledIndex ?? widget.initialPage);
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void didUpdateWidget(PhotoViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    final targetIndex = widget.controlledIndex;
    if (targetIndex != null && targetIndex != _currentIndex) {
      _jumpToIndex(targetIndex, notify: false);
    }
    if (oldWidget.photoUrls.length != widget.photoUrls.length &&
        _currentIndex >= widget.photoUrls.length) {
      _jumpToIndex(
        widget.photoUrls.isEmpty ? 0 : widget.photoUrls.length - 1,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _clampIndex(int index) {
    if (widget.photoUrls.isEmpty) return 0;
    if (index < 0) return 0;
    if (index >= widget.photoUrls.length) return widget.photoUrls.length - 1;
    return index;
  }

  void jumpToIndex(int index) => _jumpToIndex(index);

  void _jumpToIndex(int index, {bool notify = true}) {
    final target = _clampIndex(index);
    if (target == _currentIndex && notify) return;

    setState(() => _currentIndex = target);
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        target,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    }
    if (notify) widget.onPageChanged?.call(target);
  }

  @override
  Widget build(BuildContext context) {
    final viewerHeight = widget.height ?? 530;
    final showPreview =
        widget.showPlanningPreview && widget.previewPlan != null;
    final transform = widget.previewPlan?.imageTransform;

    return Stack(
      children: [
        Container(
          height: viewerHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.photoUrls.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
              widget.onPageChanged?.call(index);
            },
            itemBuilder: (context, index) {
              Widget image = Image.network(
                widget.photoUrls[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 64,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              );

              if (showPreview &&
                  index == _currentIndex &&
                  transform != null &&
                  transform != const ImageTransform()) {
                image = Transform(
                  alignment: Alignment.center,
                  transform: ImageTransformMatrix.toMatrix(
                    transform,
                    Size(
                      MediaQuery.sizeOf(context).width,
                      viewerHeight,
                    ),
                  ),
                  child: image,
                );
              }

              return ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    image,
                    if (showPreview && index == _currentIndex)
                      SmilePlanPreviewOverlay(plan: widget.previewPlan!),
                  ],
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: PatientPhotoThumbnailRail(
            photoUrls: widget.photoUrls,
            selectedIndex: _currentIndex,
            plannedPhotoUrls: widget.plannedPhotoUrls,
            maxHeight: viewerHeight * 0.45,
            onPhotoSelected: _jumpToIndex,
            onAddPhoto: widget.onAddPhoto,
          ),
        ),
      ],
    );
  }
}
