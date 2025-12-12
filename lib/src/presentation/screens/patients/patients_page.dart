import 'package:aurea_app/src/logic/cubit/patient/patient_cubit.dart';
import 'package:aurea_app/src/logic/cubit/patient/patient_state.dart';
import 'package:aurea_app/src/presentation/widgets/clinic/clinic_card.dart';
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

              return InfiniteScrollWidget(
                hasMoreData: hasMore,
                isLoading: false,
                scrollController: _scrollController,
                onLoadMore: () async {
                  await context.read<PatientCubit>().loadMore();
                },
                wrapInScrollView: false,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: patients.length,
                  itemBuilder: (context, index) {
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

