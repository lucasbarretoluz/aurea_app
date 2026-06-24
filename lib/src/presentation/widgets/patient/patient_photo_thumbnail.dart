import 'package:aurea_app/src/presentation/widgets/patient/patient_photo_placeholder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PatientPhotoThumbnail extends StatelessWidget {
  final String? photoUrl;
  final BoxFit fit;
  final double placeholderIconSize;
  final bool showEmptyLabel;
  final Color placeholderBackgroundColor;

  const PatientPhotoThumbnail({
    super.key,
    required this.photoUrl,
    this.fit = BoxFit.cover,
    this.placeholderIconSize = 40,
    this.showEmptyLabel = true,
    this.placeholderBackgroundColor = const Color(0xFF424242),
  });

  bool get _hasPhoto => photoUrl != null && photoUrl!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    if (!_hasPhoto) {
      return PatientPhotoPlaceholder(
        iconSize: placeholderIconSize,
        showLabel: showEmptyLabel,
        backgroundColor: placeholderBackgroundColor,
      );
    }

    return CachedNetworkImage(
      imageUrl: photoUrl!,
      fit: fit,
      fadeInDuration: Duration.zero,
      fadeOutDuration: Duration.zero,
      useOldImageOnUrlChange: true,
      placeholder:
          (_, __) => ColoredBox(color: placeholderBackgroundColor),
      errorWidget:
          (_, __, ___) => PatientPhotoPlaceholder(
            iconSize: placeholderIconSize,
            showLabel: showEmptyLabel,
            backgroundColor: placeholderBackgroundColor,
          ),
    );
  }
}
