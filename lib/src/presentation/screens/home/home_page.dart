import 'package:aurea_app/src/data/models/clinic/clinic_model.dart';
import 'package:aurea_app/src/logic/cubit/clinic/clinic_cubit.dart';
import 'package:aurea_app/src/logic/cubit/patient/patient_cubit.dart';
import 'package:aurea_app/src/presentation/screens/home/widgets/all_patients_section.dart';
import 'package:aurea_app/src/presentation/widgets/clinic/clinic_cards_grid.dart';
import 'package:aurea_app/src/presentation/widgets/clinic/clinic_tab_bar.dart';
import 'package:aurea_app/src/presentation/widgets/shimmer/shimmer_rectangle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

        if (clinicState.toString().startsWith('ClinicState.initial') ||
            clinicState.toString().startsWith('ClinicState.loading')) {
          return ShimmerRectangle(
            height: double.infinity,
            width: double.infinity,
          );
        } else if (clinicState.toString().startsWith('ClinicState.loaded')) {
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
            SizedBox(
              height: 300,
              child: BlocBuilder<ClinicCubit, ClinicState>(
                builder: (context, state) {
                  final stateString = state.toString();

                  if (stateString.startsWith('ClinicState.initial') ||
                      stateString.startsWith('ClinicState.loading')) {
                    return ShimmerRectangle(
                      width: double.infinity,
                      height: 300,
                      borderRadius: 12,
                    );
                  }

                  if (stateString.startsWith('ClinicState.error')) {
                    try {
                      final errorState = state as dynamic;
                      return Center(
                        child: Text(
                          'Erro: ${errorState.message ?? "Erro desconhecido"}',
                        ),
                      );
                    } catch (_) {
                      return const Center(
                        child: Text('Erro ao carregar dados'),
                      );
                    }
                  }

                  if (clinics.isEmpty) {
                    return const Center(
                      child: Text('Nenhuma clínica encontrada'),
                    );
                  }

                  final selectedClinic =
                      _selectedTabIndex < clinics.length
                          ? clinics[_selectedTabIndex]
                          : null;

                  if (selectedClinic == null) {
                    return const Center(child: Text('Clínica não encontrada'));
                  }

                  return ClinicCardsGrid(
                    patients: selectedClinic.patients,
                    clinicName: selectedClinic.name,
                    clinicId: selectedClinic.clinicId,
                  );
                },
              ),
            ),
            const AllPatientsSection(),
          ],
        );
      },
    );
  }
}
