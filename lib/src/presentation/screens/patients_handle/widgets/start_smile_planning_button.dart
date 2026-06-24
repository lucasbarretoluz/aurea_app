import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/presentation/widgets/buttons/loading_button.dart';
import 'package:aurea_app/src/presentation/widgets/toast/custom_toast.dart';
import 'package:aurea_app/src/smile_planning/models/smile_plan.dart';
import 'package:aurea_app/src/smile_planning/models/smile_planning_step.dart';
import 'package:aurea_app/src/smile_planning/utils/smile_plan_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class StartSmilePlanningButton extends StatelessWidget {
  final PatientModel patient;
  final int clinicId;
  final String clinicName;
  final List<String> photoUrls;
  final String selectedPhotoUrl;
  final SmilePlan? selectedPlan;
  final bool isUploading;
  final Future<void> Function()? onPlanningFinished;

  const StartSmilePlanningButton({
    super.key,
    required this.patient,
    required this.clinicId,
    required this.clinicName,
    required this.photoUrls,
    required this.selectedPhotoUrl,
    this.selectedPlan,
    this.isUploading = false,
    this.onPlanningFinished,
  });

  String get _buttonLabel {
    final plan = selectedPlan;
    if (plan == null) return 'Planejar sorriso';
    if (plan.isCompleted) return 'Ver resultado';
    return 'Continuar planejamento';
  }

  Future<void> _onPressed(BuildContext context) async {
    if (photoUrls.isEmpty || selectedPhotoUrl.isEmpty) {
      showToast(
        context: context,
        title: 'Adicione fotos',
        description:
            'Cadastre fotos do paciente para iniciar o planejamento.',
        type: ToastificationType.warning,
      );
      return;
    }

    final plan = selectedPlan;
    final initialRoute =
        plan != null && !plan.isCompleted
            ? plan.currentStep.routePath
            : plan?.isCompleted == true
            ? SmilePlanningStep.designResult.routePath
            : SmilePlanningStep.faceCenter.routePath;

    await context.push(
      initialRoute,
      extra: {
        'patient': patient,
        'clinicId': clinicId,
        'clinicName': clinicName,
        'photoUrls': photoUrls,
        'selectedPhotoUrl': selectedPhotoUrl,
      },
    );

    await onPlanningFinished?.call();
  }

  @override
  Widget build(BuildContext context) {
    final hasPhotos = photoUrls.isNotEmpty && selectedPhotoUrl.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: LoadingButton(
        text: _buttonLabel,
        isLoading: isUploading,
        isDisabled: !hasPhotos || isUploading,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        height: 52,
        borderRadius: 26,
        onPressed: () => _onPressed(context),
      ),
    );
  }
}
