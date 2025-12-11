import 'package:flutter/material.dart';

class AddCard extends StatelessWidget {
  const AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: const Center(
        child: Icon(
          Icons.add,
          size: 48,
          color: Colors.white,
        ),
      ),
    );
  }
}

