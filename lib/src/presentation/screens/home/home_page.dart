import 'package:aurea_app/src/data/models/clinic/clinic_model.dart';
import 'package:aurea_app/src/logic/cubit/clinic/clinic_cubit.dart';
import 'package:aurea_app/src/logic/cubit/patient/patient_cubit.dart';
import 'package:aurea_app/src/logic/cubit/patient/patient_state.dart';
import 'package:aurea_app/src/presentation/screens/home/widgets/all_patients_section.dart';
import 'package:aurea_app/src/presentation/screens/home/widgets/empty_clinic_state.dart';
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
      final clinicCubit = context.read<ClinicCubit>();
      if (clinicCubit.state.shouldReload) {
        clinicCubit.loadClinics();
      }

      final patientCubit = context.read<PatientCubit>();
      final patientState = patientCubit.state;

      switch (patientState) {
        case Initial():
          patientCubit.loadPatients(page: 1, limit: 5);
        case Loaded(:final limit):
          if (limit < 5) {
            patientCubit.loadPatients(page: 1, limit: 5);
          }
        case Error():
          patientCubit.loadPatients(page: 1, limit: 5);
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const HomePageView();
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
        if (clinicState.isInitialOrLoading) {
          return const ShimmerRectangle(
            height: double.infinity,
            width: double.infinity,
          );
        }

        final errorMessage = clinicState.errorMessage;
        if (errorMessage != null) {
          return Center(child: Text('Erro: $errorMessage'));
        }

        final clinics = clinicState.clinicsOrNull;
        if (clinics == null) {
          return const Center(child: Text('Erro ao carregar clínicas'));
        }

        return _buildHomeContent(context, clinics);
      },
    );
  }

  Widget _buildHomeContent(BuildContext context, List<ClinicModel> clinics) {
    final tabs = clinics.map((clinic) => clinic.name).toList();

    if (clinics.isEmpty) {
      return EmptyClinicState(
        isLoading: false,
        onCreateClinic: (name) async {
          await context.read<ClinicCubit>().createClinic(name);
        },
      );
    }

    final selectedClinic =
        _selectedTabIndex < clinics.length ? clinics[_selectedTabIndex] : null;

    if (selectedClinic == null) {
      return const Center(child: Text('Clínica não encontrada'));
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
          child: ClinicCardsGrid(
            patients: selectedClinic.patients,
            clinicName: selectedClinic.name,
            clinicId: selectedClinic.clinicId,
          ),
        ),
        const AllPatientsSection(),
      ],
    );
  }
}
