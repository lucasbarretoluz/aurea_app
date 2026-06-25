import 'package:aurea_app/src/data/models/clinic/clinic_model.dart';
import 'package:aurea_app/src/logic/cubit/clinic/clinic_cubit.dart';
import 'package:aurea_app/src/presentation/screens/home/widgets/clinic_delete_confirm_dialog.dart';
import 'package:aurea_app/src/presentation/screens/home/widgets/create_clinic_dialog.dart';
import 'package:aurea_app/src/presentation/screens/settings/widgets/clinic_management_tile.dart';
import 'package:aurea_app/src/presentation/screens/settings/widgets/setting_section.dart';
import 'package:aurea_app/src/presentation/widgets/shimmer/shimmer_rectangle.dart';
import 'package:aurea_app/src/presentation/widgets/toast/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClinicsManagementPage extends StatelessWidget {
  const ClinicsManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClinicsManagementPageView();
  }
}

class ClinicsManagementPageView extends StatefulWidget {
  const ClinicsManagementPageView({super.key});

  @override
  State<ClinicsManagementPageView> createState() =>
      _ClinicsManagementPageViewState();
}

class _ClinicsManagementPageViewState extends State<ClinicsManagementPageView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<ClinicCubit>();
      if (cubit.state.shouldReload) {
        cubit.loadClinics();
      }
    });
  }

  Future<void> _createClinic() async {
    final clinicCubit = context.read<ClinicCubit>();

    final name = await CreateClinicDialog.show(
      context: context,
      onSubmit: (value) => clinicCubit.createClinic(value),
    );

    if (name != null && mounted) {
      showToast(
        context: context,
        title: 'Clínica criada com sucesso',
        description: name,
      );
    }
  }

  Future<void> _renameClinic(ClinicModel clinic) async {
    final clinicCubit = context.read<ClinicCubit>();

    final name = await CreateClinicDialog.show(
      context: context,
      title: 'Renomear clínica',
      confirmLabel: 'Salvar',
      initialName: clinic.name,
      onSubmit: (value) => clinicCubit.updateClinic(
        clinicId: clinic.clinicId,
        name: value,
      ),
    );

    if (name != null && mounted) {
      showToast(
        context: context,
        title: 'Clínica atualizada',
        description: name,
      );
    }
  }

  Future<void> _deleteClinic(ClinicModel clinic) async {
    final confirmed = await ClinicDeleteConfirmDialog.show(
      context: context,
      clinicName: clinic.name,
      patientCount: clinic.patients.length,
    );

    if (!confirmed || !mounted) return;

    await context.read<ClinicCubit>().deleteClinic(clinic.clinicId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultórios'),
      ),
      body: BlocBuilder<ClinicCubit, ClinicState>(
        builder: (context, state) {
          if (state.isInitialOrLoading) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: ShimmerRectangle(height: 200, width: double.infinity),
            );
          }

          final errorMessage = state.errorMessage;
          if (errorMessage != null) {
            return Center(child: Text('Erro: $errorMessage'));
          }

          final clinics = state.clinicsOrNull ?? [];

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Organize seus pacientes em consultórios. Você também pode segurar uma aba na home para editar ou excluir.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.65),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _createClinic,
                icon: const Icon(Icons.add),
                label: const Text('Adicionar consultório'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              if (clinics.isEmpty)
                const _ClinicsEmptyState()
              else
                SettingSection(
                  title: 'Seus consultórios',
                  children: [
                    for (var i = 0; i < clinics.length; i++) ...[
                      if (i > 0)
                        Divider(
                          height: 1,
                          indent: 16,
                          endIndent: 16,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.08),
                        ),
                      ClinicManagementTile(
                        clinic: clinics[i],
                        onRename: () => _renameClinic(clinics[i]),
                        onDelete: () => _deleteClinic(clinics[i]),
                      ),
                    ],
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}

class _ClinicsEmptyState extends StatelessWidget {
  const _ClinicsEmptyState();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Icon(
            Icons.local_hospital_outlined,
            size: 56,
            color: colorScheme.primary.withValues(alpha: 0.6),
          ),
          const SizedBox(height: 16),
          const Text(
            'Nenhum consultório cadastrado',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Adicione um consultório para começar a organizar seus pacientes.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
