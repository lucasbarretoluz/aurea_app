import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PatientHandleBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const PatientHandleBackButton({super.key, this.onPressed});

  static const double _size = 40;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed ?? () => context.pop(),
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
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
    );
  }
}
