import 'package:aurea_app/src/data/models/clinic/clinic_model.dart';
import 'package:aurea_app/src/presentation/screens/home/widgets/clinic_delete_confirm_dialog.dart';
import 'package:aurea_app/src/presentation/screens/home/widgets/create_clinic_dialog.dart';
import 'package:flutter/material.dart';

class ClinicOptionsSheet extends StatelessWidget {
  final ClinicModel clinic;
  final Future<void> Function(int clinicId, String name) onRename;
  final Future<void> Function(int clinicId) onDelete;

  const ClinicOptionsSheet({
    super.key,
    required this.clinic,
    required this.onRename,
    required this.onDelete,
  });

  static Future<void> show({
    required BuildContext context,
    required ClinicModel clinic,
    required Future<void> Function(int clinicId, String name) onRename,
    required Future<void> Function(int clinicId) onDelete,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => ClinicOptionsSheet(
        clinic: clinic,
        onRename: onRename,
        onDelete: onDelete,
      ),
    );
  }

  Future<void> _handleRename(BuildContext context) async {
    Navigator.of(context).pop();

    final name = await CreateClinicDialog.show(
      context: context,
      title: 'Renomear clínica',
      confirmLabel: 'Salvar',
      initialName: clinic.name,
      onSubmit: (value) => onRename(clinic.clinicId, value),
    );

    if (name == null || !context.mounted) return;
  }

  Future<void> _handleDelete(BuildContext context) async {
    Navigator.of(context).pop();

    final confirmed = await ClinicDeleteConfirmDialog.show(
      context: context,
      clinicName: clinic.name,
      patientCount: clinic.patients.length,
    );

    if (!confirmed || !context.mounted) return;

    await onDelete(clinic.clinicId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  clinic.name,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text(
                'Renomear',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
              onTap: () => _handleRename(context),
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Color(0xFFB3261E)),
              title: const Text(
                'Excluir',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color(0xFFB3261E),
                ),
              ),
              onTap: () => _handleDelete(context),
            ),
          ],
        ),
      ),
    );
  }
}
