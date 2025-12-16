import 'package:flutter/material.dart';

class ShadowGradientContainer extends StatelessWidget {
  final Widget child;
  final Color? colorGradient;
  final double? height;
  final double? width;
  final double? borderRadius;
  final double innerBorderRadius;
  final bool disableShadow;

  const ShadowGradientContainer({
    super.key,
    required this.child,
    this.colorGradient,
    this.height,
    this.width,
    this.borderRadius = 20,
    this.innerBorderRadius = 10,
    this.disableShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColorGradient =
        colorGradient ?? const Color.fromARGB(255, 221, 220, 220);

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: defaultColorGradient,
        borderRadius: borderRadius != null ? BorderRadius.circular(borderRadius!) : null,
        boxShadow: disableShadow ? null : [
          BoxShadow(
            color: defaultColorGradient.withOpacity(0.12),
            offset: const Offset(40, 20),
            blurRadius: 10,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: defaultColorGradient.withOpacity(0.9),
            offset: const Offset(15, -5),
            blurRadius: 20,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: defaultColorGradient.withOpacity(0.9),
            offset: const Offset(-15, -5),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(innerBorderRadius),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              defaultColorGradient.withOpacity(0.9),
              defaultColorGradient.withOpacity(0.3),
              const Color(0xFFE0E0E0).withOpacity(0.5),
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}

