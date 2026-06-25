import 'package:flutter/material.dart';

class ClinicDeleteConfirmDialog extends StatelessWidget {
  final String clinicName;
  final int patientCount;

  const ClinicDeleteConfirmDialog({
    super.key,
    required this.clinicName,
    required this.patientCount,
  });

  static Future<bool> show({
    required BuildContext context,
    required String clinicName,
    required int patientCount,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ClinicDeleteConfirmDialog(
        clinicName: clinicName,
        patientCount: patientCount,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final patientsMessage = patientCount > 0
        ? ' Todos os $patientCount paciente(s) e seus dados serão apagados.'
        : '';

    return AlertDialog(
      title: const Text(
        'Excluir clínica?',
        style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w700),
      ),
      content: Text(
        'A clínica "$clinicName" será removida permanentemente.$patientsMessage',
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
