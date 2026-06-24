import 'package:flutter/material.dart';

class PatientHandlePhotoMenuButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const PatientHandlePhotoMenuButton({super.key, this.onPressed});

  static const double _size = 40;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Ink(
          width: _size,
          height: _size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Colors.black.withValues(alpha: 0.5),
                Colors.black.withValues(alpha: 0.22),
              ],
            ),
          ),
          child: const Icon(
            Icons.more_horiz,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }
}
