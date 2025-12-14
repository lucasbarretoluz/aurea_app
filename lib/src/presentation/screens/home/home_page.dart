import 'package:aurea_app/src/data/models/clinic/clinic_model.dart';
import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/logic/cubit/clinic/clinic_cubit.dart';
import 'package:aurea_app/src/logic/cubit/patient/patient_cubit.dart';
import 'package:aurea_app/src/logic/cubit/patient/patient_state.dart';
import 'package:aurea_app/src/presentation/widgets/clinic/clinic_cards_grid.dart';
import 'package:aurea_app/src/presentation/widgets/clinic/clinic_tab_bar.dart';
import 'package:aurea_app/src/presentation/screens/home/widgets/patient_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final patientCubit = context.read<PatientCubit>();
      final stateString = patientCubit.state.toString();
      if (stateString.startsWith('PatientState.initial')) {
        patientCubit.loadPatients(page: 1, limit: 5);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClinicCubit()..loadClinics(),
      child: const HomePageView(),
    );
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClinicCubit, ClinicState>(
      builder: (context, clinicState) {
        final List<String> tabs = [];
        List<ClinicModel> clinics = [];

        if (clinicState.toString().startsWith('ClinicState.loaded')) {
          try {
            final loadedState = clinicState as dynamic;
            if (loadedState.clinics != null) {
              clinics = loadedState.clinics as List<ClinicModel>;
              tabs.addAll(clinics.map((c) => c.name));
            }
          } catch (_) {}
        }

        return Column(
          children: [
            ClinicTabBar(
              tabs: tabs,
              selectedIndex: _selectedTabIndex,
              onTabSelected: (index) {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
            ),
            //nao coloque um expanded aqui!
            HomePageContent(
              selectedTabIndex: _selectedTabIndex,
              clinics: clinics,
            ),
            const AllPatientsSection(),
          ],
        );
      },
    );
  }
}

class HomePageContent extends StatelessWidget {
  final int selectedTabIndex;
  final List<ClinicModel> clinics;

  const HomePageContent({
    super.key,
    required this.selectedTabIndex,
    required this.clinics,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClinicCubit, ClinicState>(
      builder: (context, state) {
        final stateString = state.toString();

        if (stateString.startsWith('ClinicState.initial') ||
            stateString.startsWith('ClinicState.loading')) {
          return const Center(child: CircularProgressIndicator());
        }

        if (stateString.startsWith('ClinicState.error')) {
          try {
            final errorState = state as dynamic;
            return Center(
              child: Text('Erro: ${errorState.message ?? "Erro desconhecido"}'),
            );
          } catch (_) {
            return const Center(child: Text('Erro ao carregar dados'));
          }
        }

        if (clinics.isEmpty) {
          return const Center(child: Text('Nenhuma clínica encontrada'));
        }

        final selectedClinic =
            selectedTabIndex < clinics.length
                ? clinics[selectedTabIndex]
                : null;

        if (selectedClinic == null) {
          return const Center(child: Text('Clínica não encontrada'));
        }

        return ClinicCardsGrid(
          patients: selectedClinic.patients,
          category: selectedClinic.name,
        );
      },
    );
  }
}

class AllPatientsSection extends StatelessWidget {
  const AllPatientsSection({super.key});

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
                          context.push('/patients');
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
                              child: PatientCard(
                                name: patient.name,
                                clinicName: patient.clinicName,
                                subtitle: patient.description,
                                imageUrl: patient.profilePhotoUrl,
                                gender: patient.gender,
                              ),
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
