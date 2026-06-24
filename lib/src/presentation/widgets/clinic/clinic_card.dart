import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/presentation/widgets/patient/patient_photo_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClinicCard extends StatelessWidget {
  final PatientModel patient;
  final StackFit fit;

  const ClinicCard({
    super.key,
    required this.patient,
    this.fit = StackFit.expand,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => context.push(
            '/patients-handle',
            extra: {
              'patient': patient,
              'clinicId': patient.clinicId,
              'clinicName': patient.clinicName,
            },
          ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[300],
        ),
        child: Stack(
          fit: fit,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: PatientPhotoThumbnail(
                photoUrl: patient.profilePhotoUrl,
                placeholderIconSize: 48,
                placeholderBackgroundColor: Colors.grey.shade400,
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
                      patient.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (patient.description != null) ...[
                      Text(
                        patient.description ?? '',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 2),
                    ],
                    Text(
                      patient.clinicName,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
