import 'package:flutter/material.dart';

class PhotoContentContainer extends StatelessWidget {
  final Widget child;

  const PhotoContentContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 530,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: child,
    );
  }
}

