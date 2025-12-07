import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'aurea',
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w500,
            letterSpacing: 20,
          ),
        ),
        Divider(color: Colors.white, thickness: 0.3, indent: 75, endIndent: 75),
        Text(
          'design app',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.w300,
            letterSpacing: 8.0,
          ),
        ),
      ],
    );
  }
}
