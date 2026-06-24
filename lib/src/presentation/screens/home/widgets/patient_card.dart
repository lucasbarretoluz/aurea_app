import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/presentation/widgets/patient/patient_photo_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PatientCard extends StatelessWidget {
  final PatientModel patient;
  final double widthImage;

  const PatientCard({super.key, required this.patient, this.widthImage = 100});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
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
          color: const Color(0xFFE0E0E0),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: SizedBox(
                width: widthImage,
                height: double.infinity,
                child: PatientPhotoThumbnail(
                  photoUrl: patient.profilePhotoUrl,
                  placeholderIconSize: 28,
                  showEmptyLabel: true,
                ),
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
                      patient.name,
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
                      patient.clinicName,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (patient.description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        patient.description!,
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
}
