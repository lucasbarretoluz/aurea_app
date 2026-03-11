import 'package:flutter/material.dart';

class ShimmerRectangle extends StatefulWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? baseColor;
  final Color? highlightColor;
  final EdgeInsets? padding;

  const ShimmerRectangle({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 12.0,
    this.baseColor,
    this.highlightColor,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  State<ShimmerRectangle> createState() => _ShimmerRectangleState();
}

class _ShimmerRectangleState extends State<ShimmerRectangle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.baseColor ?? Colors.grey[300]!;
    final highlightColor = widget.highlightColor ?? Colors.grey[100]!;

    Widget shimmerContainer = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(-1.0 - _controller.value * 2, 0.0),
              end: Alignment(1.0 - _controller.value * 2, 0.0),
              colors: [
                baseColor,
                highlightColor,
                baseColor,
              ],
              stops: const [
                0.0,
                0.5,
                1.0,
              ],
            ),
          ),
        );
      },
    );

    final effectivePadding = widget.padding;
    if (effectivePadding != null) {
      return Padding(
        padding: effectivePadding,
        child: shimmerContainer,
      );
    }

    return shimmerContainer;
  }
}