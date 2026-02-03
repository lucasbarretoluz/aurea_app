import 'package:flutter/material.dart';

class PatientNameField extends StatelessWidget {
  final TextEditingController controller;
  final String? clinicName;

  const PatientNameField({
    super.key,
    required this.controller,
    this.clinicName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.text.trim().isNotEmpty) ...[
          Text(
            controller.text.trim(),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          if (clinicName != null && clinicName!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              'Paciente ativo da pasta $clinicName',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
          const SizedBox(height: 20),
        ],
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'Nome do paciente',
            hintText: 'Digite o nome do paciente',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black, width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

