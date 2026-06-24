import 'package:flutter/material.dart';

class PatientPhotoPlaceholder extends StatelessWidget {
  final double iconSize;
  final bool showLabel;
  final Color backgroundColor;
  final Color foregroundColor;

  const PatientPhotoPlaceholder({
    super.key,
    this.iconSize = 40,
    this.showLabel = true,
    this.backgroundColor = const Color(0xFF424242),
    this.foregroundColor = Colors.white70,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported_outlined,
              size: iconSize,
              color: foregroundColor,
            ),
            if (showLabel) ...[
              const SizedBox(height: 6),
              Text(
                'Sem foto',
                style: TextStyle(
                  fontSize: iconSize < 36 ? 10 : 12,
                  fontWeight: FontWeight.w600,
                  color: foregroundColor,
                  fontFamily: 'Montserrat',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
