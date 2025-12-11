import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final double position;
  final int length;
  final int index;
  final ValueChanged<int> onTap;
  final Widget child;
  final bool showIsNew;
  final int indexShowIsNew;

  const NavButton({
    super.key,
    required this.child,
    required this.onTap,
    required this.position,
    required this.length,
    required this.index,
    this.showIsNew = false,
    this.indexShowIsNew = 0,
  });

  @override
  Widget build(BuildContext context) {
    final desiredPosition = 1.0 / length * index;
    final difference = (position - desiredPosition).abs();
    final verticalAlignment = 1 - length * difference;
    final opacity = length * difference;
    final isSelected = difference < 1.0 / length * 0.99;
    
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          onTap(index);
        },
        child: SizedBox(
          height: 75.0,
          child: Stack(
            children: [
              if (!isSelected)
                Positioned(
                  bottom: 8,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Color(0xffBDBDBD),
                        shape: BoxShape.circle,
                      ),
                      child: Center(child: child),
                    ),
                  ),
                ),
              Transform.translate(
                offset: Offset(
                  0,
                  difference < 1.0 / length ? verticalAlignment * 40 : 0,
                ),
                child: Opacity(
                  opacity: isSelected ? opacity : 1.0,
                  child: isSelected ? child : const SizedBox.shrink(),
                ),
              ),
              if (showIsNew && index == indexShowIsNew)
                Positioned(
                  bottom: 45,
                  right: 18,
                  child: Container(
                    width: 13,
                    height: 13,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
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
