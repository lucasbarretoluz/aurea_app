import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AureaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AureaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Text(
          'aurea',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            letterSpacing: 10,
          ),
        ),
      ),
      centerTitle: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
