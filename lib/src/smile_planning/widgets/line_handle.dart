import 'package:flutter/material.dart';

class LineHandle extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPanStart;
  final void Function(DragUpdateDetails details)? onPanUpdate;
  final VoidCallback? onPanEnd;
  final double size;

  const LineHandle({
    super.key,
    required this.icon,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.size = 36,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: onPanStart != null ? (_) => onPanStart!() : null,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd != null ? (_) => onPanEnd!() : null,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 1.5),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: size * 0.45, color: Colors.black),
      ),
    );
  }
}
