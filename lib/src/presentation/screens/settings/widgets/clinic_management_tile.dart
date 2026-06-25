import 'package:aurea_app/src/data/models/clinic/clinic_model.dart';
import 'package:flutter/material.dart';

class ClinicManagementTile extends StatelessWidget {
  final ClinicModel clinic;
  final VoidCallback onRename;
  final VoidCallback onDelete;

  const ClinicManagementTile({
    super.key,
    required this.clinic,
    required this.onRename,
    required this.onDelete,
  });

  String _patientLabel(int count) {
    if (count == 1) return '1 paciente';
    return '$count pacientes';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colorScheme.onPrimaryContainer.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.local_hospital_outlined,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clinic.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _patientLabel(clinic.patients.length),
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Renomear',
            onPressed: onRename,
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            tooltip: 'Excluir',
            onPressed: onDelete,
            icon: Icon(
              Icons.delete_outline,
              color: colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}
