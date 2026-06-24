import 'dart:ui';

import 'package:flutter/material.dart';

const double _kPhotoRailTileSize = 44;
const double _kPhotoRailTileRadius = 10;
const double _kPhotoRailTileGap = 6;

class PatientPhotoThumbnailRail extends StatelessWidget {
  final List<String> photoUrls;
  final int selectedIndex;
  final Set<String> plannedPhotoUrls;
  final double maxHeight;
  final ValueChanged<int> onPhotoSelected;
  final VoidCallback onAddPhoto;

  const PatientPhotoThumbnailRail({
    super.key,
    required this.photoUrls,
    required this.selectedIndex,
    required this.plannedPhotoUrls,
    required this.maxHeight,
    required this.onPhotoSelected,
    required this.onAddPhoto,
  });

  @override
  Widget build(BuildContext context) {
    if (photoUrls.isEmpty) {
      return PatientPhotoAddTile(
        backgroundImageUrl: null,
        onTap: onAddPhoto,
      );
    }

    final addTileBackground =
        selectedIndex < photoUrls.length ? photoUrls[selectedIndex] : photoUrls.last;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var index = 0; index < photoUrls.length; index++) ...[
                  if (index > 0) const SizedBox(height: _kPhotoRailTileGap),
                  PatientPhotoThumbnailTile(
                    imageUrl: photoUrls[index],
                    isSelected: index == selectedIndex,
                    hasPlan: plannedPhotoUrls.contains(photoUrls[index]),
                    onTap: () => onPhotoSelected(index),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: _kPhotoRailTileGap),
        PatientPhotoAddTile(
          backgroundImageUrl: addTileBackground,
          onTap: onAddPhoto,
        ),
      ],
    );
  }
}

class PatientPhotoThumbnailTile extends StatelessWidget {
  final String imageUrl;
  final bool isSelected;
  final bool hasPlan;
  final VoidCallback onTap;

  const PatientPhotoThumbnailTile({
    super.key,
    required this.imageUrl,
    required this.isSelected,
    required this.hasPlan,
    required this.onTap,
  });

  static const double _size = _kPhotoRailTileSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: _size,
        height: _size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_kPhotoRailTileRadius),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.35),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_kPhotoRailTileRadius - 2),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => ColoredBox(
                  color: Colors.grey.shade700,
                  child: const Icon(Icons.broken_image, size: 16, color: Colors.white),
                ),
              ),
              if (hasPlan)
                Positioned(
                  right: 3,
                  top: 3,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1B7F4B),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class PatientPhotoAddTile extends StatelessWidget {
  final String? backgroundImageUrl;
  final VoidCallback onTap;

  const PatientPhotoAddTile({
    super.key,
    required this.backgroundImageUrl,
    required this.onTap,
  });

  static const double _size = _kPhotoRailTileSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: _size,
        height: _size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_kPhotoRailTileRadius),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.35),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_kPhotoRailTileRadius - 2),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (backgroundImageUrl != null)
                ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Image.network(
                    backgroundImageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => ColoredBox(color: Colors.grey.shade800),
                  ),
                )
              else
                ColoredBox(color: Colors.grey.shade800),
              ColoredBox(color: Colors.black.withValues(alpha: 0.35)),
              const Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
