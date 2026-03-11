import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/logic/cubit/patient/patient_cubit.dart';
import 'package:aurea_app/src/logic/cubit/patient/patient_state.dart';
import 'package:aurea_app/src/presentation/screens/home/widgets/patient_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AllPatientsSection extends StatefulWidget {
  const AllPatientsSection({super.key});

  @override
  State<AllPatientsSection> createState() => _AllPatientsSectionState();
}

class _AllPatientsSectionState extends State<AllPatientsSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final patientCubit = context.read<PatientCubit>();
      final stateString = patientCubit.state.toString();

      if (stateString.startsWith('PatientState.initial')) {
        patientCubit.loadPatients(page: 1, limit: 5);
      } else if (stateString.startsWith('PatientState.loaded')) {
        try {
          final loadedState = patientCubit.state as dynamic;
          final limit = loadedState.limit as int;
          if (limit < 5) {
            patientCubit.loadPatients(page: 1, limit: 5);
          }
        } catch (_) {
          patientCubit.loadPatients(page: 1, limit: 5);
        }
      } else if (stateString.startsWith('PatientState.error')) {
        patientCubit.loadPatients(page: 1, limit: 5);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientCubit, PatientState>(
      builder: (context, state) {
        final stateString = state.toString();

        if (stateString.startsWith('PatientState.loaded')) {
          try {
            final loadedState = state as dynamic;
            final patients = loadedState.patients as List<PatientModel>;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Todos os pacientes',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.push('/all-patients');
                        },
                        child: const Text('Ver todos'),
                      ),
                    ],
                  ),
                  if (patients.isNotEmpty)
                    SizedBox(
                      height: 130,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: patients.length,
                        itemBuilder: (context, index) {
                          final patient = patients[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: SizedBox(
                              width: 240,
                              child: PatientCard(patient: patient),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          } catch (e) {
            return const SizedBox.shrink();
          }
        }

        return const SizedBox.shrink();
      },
    );
  }
}
