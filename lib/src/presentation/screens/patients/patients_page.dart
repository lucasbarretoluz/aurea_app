import 'package:aurea_app/src/logic/cubit/patient/patient_cubit.dart';
import 'package:aurea_app/src/logic/cubit/patient/patient_state.dart';
import 'package:aurea_app/src/presentation/widgets/clinic/clinic_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientsPage extends StatelessWidget {
  const PatientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientCubit()..loadPatients(page: 1, limit: 20),
      child: const PatientsPageView(),
    );
  }
}

class PatientsPageView extends StatelessWidget {
  const PatientsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos os Pacientes'),
      ),
      body: BlocBuilder<PatientCubit, PatientState>(
        builder: (context, state) {
          final stateString = state.toString();

          if (stateString.startsWith('PatientState.initial') ||
              stateString.startsWith('PatientState.loading')) {
            return const Center(child: CircularProgressIndicator());
          }

          if (stateString.startsWith('PatientState.error')) {
            try {
              final errorState = state as dynamic;
              return Center(
                child: Text('Erro: ${errorState.message ?? "Erro desconhecido"}'),
              );
            } catch (_) {
              return const Center(child: Text('Erro ao carregar pacientes'));
            }
          }

          if (stateString.startsWith('PatientState.loaded')) {
            try {
              final loadedState = state as dynamic;
              final patients = loadedState.patients as List;
              final hasMore = loadedState.hasMore as bool;

              if (patients.isEmpty) {
                return const Center(child: Text('Nenhum paciente encontrado'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: patients.length + (hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == patients.length) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<PatientCubit>().loadMore();
                          },
                          child: const Text('Carregar mais'),
                        ),
                      ),
                    );
                  }

                  final patient = patients[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ClinicCard(
                      title: patient.name,
                      subtitle: patient.description ?? 'Paciente ativo da pasta',
                      category: 'Paciente',
                      imageUrl: patient.profilePhotoUrl,
                    ),
                  );
                },
              );
            } catch (_) {
              return const Center(child: Text('Erro ao carregar pacientes'));
            }
          }

          return const Center(child: Text('Estado desconhecido'));
        },
      ),
    );
  }
}

