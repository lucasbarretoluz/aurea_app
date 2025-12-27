import 'package:aurea_app/src/core/enums/gender_enum.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PatientCard extends StatelessWidget {
  final String name;
  final String clinicName;
  final String? subtitle;
  final String? imageUrl;
  final GenderEnum? gender;
  final double widthImage;

  const PatientCard({
    super.key,
    required this.name,
    required this.clinicName,
    this.subtitle,
    this.imageUrl,
    this.gender,
    this.widthImage = 100,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/handle-patients'),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFE0E0E0),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Container(
                width: widthImage,
                height: double.infinity,
                color: const Color(0xFF424242),
                child: _buildImage(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 5, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
      
                      maxLines: 1,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      clinicName,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
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
                color: const Color(0xFF424242),
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white70,
                ),
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
          color: const Color(0xFF424242),
          child: const Icon(
            Icons.person,
            size: 50,
            color: Colors.white70,
          ),
        );
      },
    );
  }
}
