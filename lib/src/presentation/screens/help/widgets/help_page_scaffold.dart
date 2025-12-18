import 'package:flutter/material.dart';

class HelpPageScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const HelpPageScaffold({
    super.key,
    required this.child,
     this.title = '',
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
            left: 0,
            right: 0,
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: BackButton(
                    color: Color(0xffaea79d),
                  ),
                ),
                Expanded(
                  child: title.isNotEmpty
                      ? Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xffaea79d),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : const SizedBox(),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

