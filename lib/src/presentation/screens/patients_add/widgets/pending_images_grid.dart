import 'dart:io';
import 'package:flutter/material.dart';
import 'package:aurea_app/src/presentation/screens/patients_add/widgets/add_photo_card.dart';
import 'package:aurea_app/src/presentation/screens/patients_add/widgets/pending_image_thumbnail.dart';

class PendingImagesGrid extends StatelessWidget {
  final List<File> images;
  final int? coverIndex;
  final VoidCallback onAddPhoto;
  final Function(int) onImageTap;
  final Function(int) onImageRemove;
  final Function(int) onImageCrop;

  const PendingImagesGrid({
    super.key,
    required this.images,
    this.coverIndex,
    required this.onAddPhoto,
    required this.onImageTap,
    required this.onImageRemove,
    required this.onImageCrop,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemCount: images.length + 1,
        itemBuilder: (context, index) {
          if (index == images.length) {
            return AddPhotoCard(onTap: onAddPhoto);
          }
          return PendingImageThumbnail(
            imageFile: images[index],
            isCover: coverIndex == index,
            onTap: () => onImageTap(index),
            onRemove: () => onImageRemove(index),
            onCrop: () => onImageCrop(index),
          );
        },
      ),
    );
  }
}

