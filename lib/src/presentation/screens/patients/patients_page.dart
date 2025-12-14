import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/logic/cubit/patient/patient_cubit.dart';
import 'package:aurea_app/src/logic/cubit/patient/patient_state.dart';
import 'package:aurea_app/src/presentation/screens/home/widgets/patient_card.dart';
import 'package:aurea_app/src/presentation/widgets/infinite_scroll/infinite_scroll_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final patientCubit = context.read<PatientCubit>();
      final stateString = patientCubit.state.toString();
      if (stateString.startsWith('PatientState.initial')) {
        patientCubit.loadPatients(page: 1, limit: 20);
      } else if (stateString.startsWith('PatientState.loaded')) {
        try {
          final loadedState = patientCubit.state as dynamic;
          final limit = loadedState.limit as int;
          if (limit < 20) {
            patientCubit.loadPatients(page: 1, limit: 20);
          }
        } catch (_) {
          // Se houver erro ao acessar o limit, recarrega com limit 20
          patientCubit.loadPatients(page: 1, limit: 20);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const PatientsPageView();
  }
}

class PatientsPageView extends StatefulWidget {
  const PatientsPageView({super.key});

  @override
  State<PatientsPageView> createState() => _PatientsPageViewState();
}

class _PatientsPageViewState extends State<PatientsPageView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos os Pacientes')),
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
                child: Text(
                  'Erro: ${errorState.message ?? "Erro desconhecido"}',
                ),
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
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Nenhum paciente encontrado',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Não há pacientes cadastrados no momento.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return InfiniteScrollWidget(
                hasMoreData: hasMore,
                isLoading: false,
                scrollController: _scrollController,
                onLoadMore: () async {
                  await context.read<PatientCubit>().loadMore();
                },
                wrapInScrollView: false,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.separated(
                    itemCount: patients.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final patient = patients[index] as PatientModel;
                      return SizedBox(
                        height: 130,
                        width: 100,
                        child: PatientCard(
                          widthImage: 130,
                          name: patient.name,
                          clinicName: patient.clinicName,
                          subtitle: patient.description ?? '',
                          imageUrl: patient.profilePhotoUrl,
                          gender: patient.gender,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                  ),
                ),
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
