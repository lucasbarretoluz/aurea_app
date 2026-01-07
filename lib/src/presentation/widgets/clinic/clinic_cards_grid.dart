import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/presentation/widgets/clinic/add_card.dart';
import 'package:aurea_app/src/presentation/widgets/clinic/clinic_card.dart';
import 'package:flutter/material.dart';

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
              child: AddCard(
                width: 200,
                height: 300,
                clinicName: clinicName,
                clinicId: clinicId,

              ),
            );
          }
          
          final patient = patients[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SizedBox(
              width: 200,
              child: ClinicCard(
                patient: patient,
              ),
            ),
          );
        },
      ),
    );
  }
}

