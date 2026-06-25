import 'package:aurea_app/src/data/models/clinic/clinic_model.dart';
import 'package:aurea_app/src/logic/cubit/clinic/clinic_cubit.dart';
import 'package:aurea_app/src/logic/cubit/patient/patient_cubit.dart';
import 'package:aurea_app/src/logic/cubit/patient/patient_state.dart';
import 'package:aurea_app/src/presentation/screens/home/widgets/all_patients_section.dart';
import 'package:aurea_app/src/presentation/screens/home/widgets/clinic_options_sheet.dart';
import 'package:aurea_app/src/presentation/screens/home/widgets/create_clinic_dialog.dart';
import 'package:aurea_app/src/presentation/screens/home/widgets/empty_clinic_state.dart';
import 'package:aurea_app/src/presentation/widgets/clinic/clinic_cards_grid.dart';
import 'package:aurea_app/src/presentation/widgets/clinic/clinic_tab_bar.dart';
import 'package:aurea_app/src/presentation/widgets/shimmer/shimmer_rectangle.dart';
import 'package:aurea_app/src/presentation/widgets/toast/custom_toast.dart';
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

  Future<void> _createClinic(BuildContext context) async {
    final clinicCubit = context.read<ClinicCubit>();

    final name = await CreateClinicDialog.show(
      context: context,
      onSubmit: (value) => clinicCubit.createClinic(value),
    );

    if (name == null || !context.mounted) return;

    showToast(
      context: context,
      title: 'Clínica criada com sucesso',
      description: name,
    );

    final clinics = clinicCubit.state.clinicsOrNull;
    if (clinics != null && clinics.isNotEmpty) {
      setState(() {
        _selectedTabIndex = clinics.length - 1;
      });
    }
  }

  Future<void> _openClinicOptions(
    BuildContext context,
    List<ClinicModel> clinics,
    int index,
  ) async {
    if (index >= clinics.length) return;

    final clinic = clinics[index];
    final deletedClinicId = clinic.clinicId;
    final clinicCubit = context.read<ClinicCubit>();

    await ClinicOptionsSheet.show(
      context: context,
      clinic: clinic,
      onRename: (clinicId, name) async {
        await clinicCubit.updateClinic(
          clinicId: clinicId,
          name: name,
        );
      },
      onDelete: (clinicId) async {
        await clinicCubit.deleteClinic(clinicId);

        if (!mounted) return;

        final updatedClinics = clinicCubit.state.clinicsOrNull ?? [];

        setState(() {
          if (updatedClinics.isEmpty) {
            _selectedTabIndex = 0;
            return;
          }

          final deletedIndex = clinics.indexWhere(
            (item) => item.clinicId == deletedClinicId,
          );

          if (deletedIndex == -1) return;

          if (_selectedTabIndex >= updatedClinics.length) {
            _selectedTabIndex = updatedClinics.length - 1;
          } else if (deletedIndex < _selectedTabIndex) {
            _selectedTabIndex -= 1;
          } else if (deletedIndex == _selectedTabIndex) {
            _selectedTabIndex = _selectedTabIndex.clamp(
              0,
              updatedClinics.length - 1,
            );
          }
        });
      },
    );
  }

  int _resolveSelectedIndex(int clinicCount) {
    if (clinicCount == 0) return 0;
    return _selectedTabIndex.clamp(0, clinicCount - 1);
  }

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
    final selectedIndex = _resolveSelectedIndex(clinics.length);

    if (clinics.isEmpty) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: EmptyClinicState(
                onCreateClinic: (name) async {
                  await context.read<ClinicCubit>().createClinic(name);
                },
              ),
            ),
          );
        },
      );
    }

    final selectedClinic =
        selectedIndex < clinics.length ? clinics[selectedIndex] : null;

    if (selectedClinic == null) {
      return const Center(child: Text('Clínica não encontrada'));
    }

    return Column(
      children: [
        ClinicTabBar(
          tabs: tabs,
          selectedIndex: selectedIndex,
          onTabSelected: (index) {
            setState(() {
              _selectedTabIndex = index;
            });
          },
          onTabLongPress: (index) => _openClinicOptions(context, clinics, index),
          onAddPressed: () => _createClinic(context),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
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
            ),
          ),
        ),
      ],
    );
  }
}
