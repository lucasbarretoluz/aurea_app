import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String? photoUrl;
  final bool isPremium;

  const ProfileHeader({
    super.key,
    required this.name,
    this.photoUrl,
    required this.isPremium,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 52,
              backgroundColor: colorScheme.primaryContainer,
              backgroundImage:
                  photoUrl != null && photoUrl!.isNotEmpty
                      ? NetworkImage(photoUrl!)
                      : null,
              child:
                  photoUrl == null || photoUrl!.isEmpty
                      ? Icon(
                        Icons.person,
                        size: 52,
                        color: colorScheme.onPrimaryContainer,
                      )
                      : null,
            ),
            if (isPremium)
              Positioned(
                bottom: -4,
                right: -4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFB300),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Text(
                    'Premium',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          name.isNotEmpty ? name : 'Usuário',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
        if (!isPremium) ...[
          const SizedBox(height: 8),
          Text(
            'Conta gratuita',
            style: TextStyle(
              fontSize: 13,
              color: colorScheme.onSurface.withValues(alpha: 0.6),
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ],
    );
  }
}
