import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/presentation/widgets/clinic/add_card.dart';
import 'package:aurea_app/src/presentation/widgets/clinic/clinic_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClinicCardsGrid extends StatelessWidget {
  final List<PatientModel> patients;
  final String clinicName;
  final int clinicId;

  const ClinicCardsGrid({
    super.key,
    required this.patients,
    required this.clinicName,
    required this.clinicId,
  });

  @override
  Widget build(BuildContext context) {
    final itemCount = patients.length + 1;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (index == itemCount - 1) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SizedBox(
                width: 200,
                height: 300,
                child: Column(
                  children: [
                    SizedBox(
                      height: 220,
                      child: AddCard(
                        width: 200,
                        height: 200,
                        clinicName: clinicName,
                        clinicId: clinicId,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 70,
                      child: ViewAllPatientsCard(
                        clinicName: clinicName,
                        clinicId: clinicId,
                        patients: patients,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final patient = patients[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SizedBox(width: 200, child: ClinicCard(patient: patient)),
          );
        },
      ),
    );
  }
}

class ViewAllPatientsCard extends StatelessWidget {
  final String clinicName;
  final int clinicId;
  final List<PatientModel> patients;

  const ViewAllPatientsCard({
    super.key,
    required this.clinicName,
    required this.clinicId,
    required this.patients,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        context.push(
          '/clinic-patients',
          extra: {
            'clinicName': clinicName,
            'clinicId': clinicId,
            'patients': patients,
          },
        );
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: colorScheme.secondary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ver todos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Pacientes da clínica',
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSecondary.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
