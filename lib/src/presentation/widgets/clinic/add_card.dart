import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddCard extends StatelessWidget {
  final double width;
  final double height;
  final String clinicName;
  final int clinicId;

  const AddCard({
    super.key,
    required this.width,
    required this.height,
    required this.clinicName,
    required this.clinicId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          '/patient',
          extra: {'clinicName': clinicName, 'clinicId': clinicId},
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              Positioned.fill(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Image.asset(
                    'assets/images/demo-woman.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: Colors.grey[400]);
                    },
                  ),
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(color: Colors.transparent),
                ),
              ),
              Center(
                child: const Icon(Icons.add, size: 65, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
