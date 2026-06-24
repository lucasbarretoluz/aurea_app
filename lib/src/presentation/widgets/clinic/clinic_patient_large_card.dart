import 'package:aurea_app/src/core/helpers/string_capitalize_helper.dart';
import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/presentation/widgets/patient/patient_photo_thumbnail.dart';
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
            PatientPhotoThumbnail(
              photoUrl: patient.profilePhotoUrl,
              placeholderIconSize: 56,
              placeholderBackgroundColor: Colors.grey.shade400,
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
}
