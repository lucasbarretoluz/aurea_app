import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PatientBackButton extends StatelessWidget {

  const PatientBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 10,
      child: IconButton(
        onPressed: () => context.pop(),
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 35,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}

