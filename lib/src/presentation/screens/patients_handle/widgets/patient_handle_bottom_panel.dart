import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/presentation/screens/patients_handle/models/photo_view_mode.dart';
import 'package:aurea_app/src/presentation/screens/patients_handle/widgets/patient_photo_view_mode_toggle.dart';
import 'package:aurea_app/src/presentation/screens/patients_handle/widgets/start_smile_planning_button.dart';
import 'package:aurea_app/src/presentation/widgets/buttons/loading_button.dart';
import 'package:aurea_app/src/smile_planning/models/smile_plan.dart';
import 'package:aurea_app/src/smile_planning/utils/smile_plan_extensions.dart';
import 'package:flutter/material.dart';

class PatientHandleBottomPanel extends StatelessWidget {
  final PatientModel patient;
  final String clinicName;
  final int clinicId;
  final List<String> photoUrls;
  final String selectedPhotoUrl;
  final SmilePlan? selectedPlan;
  final PhotoViewMode viewMode;
  final bool isUploading;
  final ValueChanged<PhotoViewMode> onViewModeChanged;
  final VoidCallback onAddPhoto;
  final Future<void> Function()? onPlanningFinished;

  const PatientHandleBottomPanel({
    super.key,
    required this.patient,
    required this.clinicName,
    required this.clinicId,
    required this.selectedPhotoUrl,
    required this.photoUrls,
    required this.selectedPlan,
    required this.viewMode,
    required this.isUploading,
    required this.onViewModeChanged,
    required this.onAddPhoto,
    this.onPlanningFinished,
  });

  String get _statusMessage {
    final plan = selectedPlan;
    if (plan == null) {
      return 'Esta foto ainda não tem planejamento de sorriso.';
    }
    if (plan.isCompleted) {
      return 'Planejamento concluído nesta foto.';
    }
    return 'Planejamento em andamento nesta foto.';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasPlan = selectedPlan != null;
    final hasPhotos = photoUrls.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  clinicName,
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurface.withValues(alpha: 0.65),
                    fontFamily: 'Montserrat',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (hasPhotos) ...[
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PatientPhotoViewModeToggle(
                mode: viewMode,
                planningAvailable: hasPlan,
                onChanged: onViewModeChanged,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                _statusMessage,
                style: TextStyle(
                  fontSize: 13,
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ] else ...[
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Nenhuma foto cadastrada para este paciente.',
                style: TextStyle(
                  fontSize: 13,
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ],
          const Spacer(),
          if (hasPhotos)
            StartSmilePlanningButton(
              patient: patient,
              clinicId: clinicId,
              clinicName: clinicName,
              photoUrls: photoUrls,
              selectedPhotoUrl: selectedPhotoUrl,
              selectedPlan: selectedPlan,
              isUploading: isUploading,
              onPlanningFinished: onPlanningFinished,
            )
          else
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: LoadingButton(
                text: 'Adicionar foto',
                isLoading: isUploading,
                isDisabled: isUploading,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                height: 52,
                borderRadius: 26,
                onPressed: onAddPhoto,
              ),
            ),
        ],
      ),
    );
  }
}
