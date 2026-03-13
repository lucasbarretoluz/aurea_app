import 'package:aurea_app/src/core/enums/gender_enum.dart';
import 'package:aurea_app/src/core/helpers/string_capitalize_helper.dart';
import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClinicPatientLargeCard extends StatelessWidget {
  final PatientModel patient;

  const ClinicPatientLargeCard({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          '/patients-handle',
          extra: {
            'patient': patient,
            'clinicId': patient.clinicId,
            'clinicName': patient.clinicName,
          },
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Colors.grey[400],
              child: _buildImage(),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.0),
                      Colors.black.withValues(alpha: 0.6),
                    ],
                  ),
                ),
                child: Text(
                  patient.name.capitalizeFirst(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDefaultImage() {
    if (patient.gender == GenderEnum.female) {
      return 'assets/images/demo-woman.png';
    } else if (patient.gender == GenderEnum.male) {
      return 'assets/images/demo-man.png';
    }
    return 'assets/images/demo-woman.png';
  }

  Widget _buildImage() {
    if (patient.profilePhotoUrl != null &&
        patient.profilePhotoUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: patient.profilePhotoUrl!,
        fit: BoxFit.cover,
        fadeInDuration: Duration.zero,
        fadeOutDuration: Duration.zero,
        useOldImageOnUrlChange: true,
        placeholder: (context, url) => Container(
          color: Colors.grey[400],
        ),
        errorWidget: (context, url, error) {
          return Image.asset(
            _getDefaultImage(),
            fit: BoxFit.cover,
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

