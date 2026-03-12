import 'package:aurea_app/src/presentation/widgets/form_fields/text_field_with_label.dart';
import 'package:flutter/material.dart';

class PatientInfoHeader extends StatefulWidget {
  final bool isActiveChangeName;
  final String? name;
  final String clinicName;
  final Function(String) onNameChanged;

  const PatientInfoHeader({
    super.key,
    this.name,
    this.isActiveChangeName = false,
    required this.clinicName,
    required this.onNameChanged,
  });

  @override
  State<PatientInfoHeader> createState() => _PatientInfoHeaderState();
}

class _PatientInfoHeaderState extends State<PatientInfoHeader> {
  final TextEditingController nameController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name ?? '';

    nameController.addListener(() {
      widget.onNameChanged(nameController.text);
    });

    focusNode.addListener(() {});
  }

  @override
  void dispose() {
    nameController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.folder_outlined,
                  size: 20,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Paciente ativo da pasta ${widget.clinicName}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextFieldWithLabel(
            colorLabel: Colors.black,
            hint: 'Digite o nome do paciente',
            controller: nameController,
            focusNode: focusNode,
            enabled: widget.isActiveChangeName,
            hideBorder: true,
          ),
        ],
      ),
    );
  }
}
