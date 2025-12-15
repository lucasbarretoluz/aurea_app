import 'package:flutter/material.dart';

class HelpPageScaffold extends StatelessWidget {
  final Widget child;

  const HelpPageScaffold({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
      body: Stack(
        children: [
          Positioned.fill(
            child: child,
          ),
          Positioned(
            top: statusBarHeight,
            left: 10,
            child: const BackButton(
              color: Color(0xffaea79d),
            ),
          ),
        ],
      ),
    );
  }
}

