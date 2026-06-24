import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/data/models/patient/patient_photo_model.dart';
import 'package:flutter/material.dart';

class PatientHandleOptionsSheet extends StatelessWidget {
  final PatientModel patient;
  final List<PatientPhotoItem> photos;
  final int selectedPhotoIndex;
  final Set<String> plannedPhotoUrls;
  final Future<void> Function(PatientPhotoItem photo) onDeletePhoto;
  final Future<void> Function() onDeletePatient;

  const PatientHandleOptionsSheet({
    super.key,
    required this.patient,
    required this.photos,
    required this.selectedPhotoIndex,
    required this.plannedPhotoUrls,
    required this.onDeletePhoto,
    required this.onDeletePatient,
  });

  static Future<void> show({
    required BuildContext context,
    required PatientModel patient,
    required List<PatientPhotoItem> photos,
    required int selectedPhotoIndex,
    required Set<String> plannedPhotoUrls,
    required Future<void> Function(PatientPhotoItem photo) onDeletePhoto,
    required Future<void> Function() onDeletePatient,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return PatientHandleOptionsSheet(
          patient: patient,
          photos: photos,
          selectedPhotoIndex: selectedPhotoIndex,
          plannedPhotoUrls: plannedPhotoUrls,
          onDeletePhoto: onDeletePhoto,
          onDeletePatient: onDeletePatient,
        );
      },
    );
  }

  Future<void> _confirmDeletePhoto(
    BuildContext context,
    PatientPhotoItem photo,
  ) async {
    final hasPlan = plannedPhotoUrls.contains(photo.url);
    final confirmed = await PatientPhotoDeleteConfirmDialog.show(
      context: context,
      hasPlan: hasPlan,
    );
    if (!confirmed || !context.mounted) return;

    Navigator.of(context).pop();
    await onDeletePhoto(photo);
  }

  Future<void> _confirmDeletePatient(BuildContext context) async {
    final hasPlans = plannedPhotoUrls.isNotEmpty;
    final confirmed = await PatientDeleteConfirmDialog.show(
      context: context,
      patientName: patient.name,
      hasPlans: hasPlans,
      photoCount: photos.length,
    );
    if (!confirmed || !context.mounted) return;

    Navigator.of(context).pop();
    await onDeletePatient();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.82,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 12,
        bottom: MediaQuery.paddingOf(context).bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.onSurface.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Opções do paciente',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 6),
          Text(
            patient.name,
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onSurface.withValues(alpha: 0.7),
              fontFamily: 'Montserrat',
            ),
          ),
          if (photos.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              'Excluir fotos',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface.withValues(alpha: 0.8),
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: photos.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final photo = photos[index];
                  final isSelected = index == selectedPhotoIndex;
                  final hasPlan = plannedPhotoUrls.contains(photo.url);

                  return PatientPhotoDeleteSheetTile(
                    photo: photo,
                    index: index,
                    isSelected: isSelected,
                    hasPlan: hasPlan,
                    onDelete: () => _confirmDeletePhoto(context, photo),
                  );
                },
              ),
            ),
          ],
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 12),
          PatientDeletePatientTile(
            onTap: () => _confirmDeletePatient(context),
          ),
        ],
      ),
    );
  }
}

class PatientPhotoDeleteSheetTile extends StatelessWidget {
  final PatientPhotoItem photo;
  final int index;
  final bool isSelected;
  final bool hasPlan;
  final VoidCallback onDelete;

  const PatientPhotoDeleteSheetTile({
    super.key,
    required this.photo,
    required this.index,
    required this.isSelected,
    required this.hasPlan,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color:
              isSelected
                  ? Colors.black
                  : colorScheme.onSurface.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              photo.url,
              width: 52,
              height: 52,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 52,
                height: 52,
                color: Colors.grey.shade300,
                child: const Icon(Icons.broken_image, size: 20),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Foto ${index + 1}${isSelected ? ' · atual' : ''}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                ),
                if (hasPlan) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Tem planejamento de sorriso',
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline),
            color: const Color(0xFFB3261E),
          ),
        ],
      ),
    );
  }
}

class PatientDeletePatientTile extends StatelessWidget {
  final VoidCallback onTap;

  const PatientDeletePatientTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFB3261E).withValues(alpha: 0.25)),
        ),
        child: const Row(
          children: [
            Icon(Icons.person_remove_outlined, color: Color(0xFFB3261E)),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Excluir paciente',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFB3261E),
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Remove o paciente e todas as fotos dele.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFB3261E),
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PatientPhotoDeleteConfirmDialog extends StatelessWidget {
  final bool hasPlan;

  const PatientPhotoDeleteConfirmDialog({super.key, required this.hasPlan});

  static Future<bool> show({
    required BuildContext context,
    required bool hasPlan,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => PatientPhotoDeleteConfirmDialog(hasPlan: hasPlan),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Excluir foto?',
        style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w700),
      ),
      content: Text(
        hasPlan
            ? 'Esta foto será removida e o planejamento de sorriso associado a ela também será apagado.'
            : 'Esta foto será removida permanentemente do paciente.',
        style: const TextStyle(fontFamily: 'Montserrat'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text(
            'Excluir',
            style: TextStyle(color: Color(0xFFB3261E)),
          ),
        ),
      ],
    );
  }
}

class PatientDeleteConfirmDialog extends StatelessWidget {
  final String patientName;
  final bool hasPlans;
  final int photoCount;

  const PatientDeleteConfirmDialog({
    super.key,
    required this.patientName,
    required this.hasPlans,
    required this.photoCount,
  });

  static Future<bool> show({
    required BuildContext context,
    required String patientName,
    required bool hasPlans,
    required int photoCount,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder:
          (context) => PatientDeleteConfirmDialog(
            patientName: patientName,
            hasPlans: hasPlans,
            photoCount: photoCount,
          ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final photosMessage =
        photoCount > 0
            ? ' Todas as $photoCount foto(s) serão apagadas.'
            : '';

    return AlertDialog(
      title: const Text(
        'Excluir paciente?',
        style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w700),
      ),
      content: Text(
        '$patientName será removido permanentemente.$photosMessage'
        '${hasPlans ? ' Os planejamentos de sorriso salvos localmente também serão apagados.' : ''}',
        style: const TextStyle(fontFamily: 'Montserrat'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text(
            'Excluir paciente',
            style: TextStyle(color: Color(0xFFB3261E)),
          ),
        ),
      ],
    );
  }
}
