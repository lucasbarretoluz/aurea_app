import 'package:flutter/material.dart';

class HelpPageScaffold extends StatelessWidget {
  final List<Widget> children;

  const HelpPageScaffold({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                SizedBox(height: statusBarHeight),
                ...children,
              ],
            ),
          ),
          Positioned(
            top: statusBarHeight,
            left: 10,
            child: const BackButton(),
          ),
        ],
      ),
    );
  }
}

