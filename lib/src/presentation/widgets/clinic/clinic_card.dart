import 'package:aurea_app/src/core/enums/gender_enum.dart';
import 'package:flutter/material.dart';

class ClinicCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String category;
  final String? imageUrl;
  final GenderEnum? gender;
  final StackFit fit;

  const ClinicCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.category,
    this.imageUrl,
    this.gender,
    this.fit = StackFit.expand,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[300],
      ),
      child: Stack(
        fit: fit,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: Colors.grey[400],
              child: _buildImage(),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getDefaultImage() {
    if (gender == GenderEnum.female) {
      return 'assets/images/demo-woman.png';
    } else if (gender == GenderEnum.male) {
      return 'assets/images/demo-man.png';
    }
    // Fallback padrão
    return 'assets/images/smile_woman.jpg';
  }

  Widget _buildImage() {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            _getDefaultImage(),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[400],
                child: const Icon(Icons.person, size: 80, color: Colors.white70),
              );
            },
          );
        },
      );
    }

    return Image.asset(
      _getDefaultImage(),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[400],
          child: const Icon(Icons.person, size: 80, color: Colors.white70),
        );
      },
    );
  }
}

