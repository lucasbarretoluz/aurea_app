import 'dart:io';
import 'package:flutter/material.dart';
import 'package:aurea_app/src/presentation/screens/patients/widgets/add_photo_card.dart';
import 'package:aurea_app/src/presentation/screens/patients/widgets/pending_image_thumbnail.dart';

class PendingImagesGrid extends StatelessWidget {
  final List<File> images;
  final int? selectedIndex;
  final VoidCallback onAddPhoto;
  final Function(int) onImageTap;
  final Function(int) onImageRemove;

  const PendingImagesGrid({
    super.key,
    required this.images,
    this.selectedIndex,
    required this.onAddPhoto,
    required this.onImageTap,
    required this.onImageRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60),
      height: 500,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
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
            isSelected: selectedIndex == index,
            onTap: () => onImageTap(index),
            onRemove: () => onImageRemove(index),
          );
        },
      ),
    );
  }
}

