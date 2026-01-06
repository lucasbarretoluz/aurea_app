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
      setState(() {});
    });

    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          enabled: widget.isActiveChangeName,
          controller: nameController,
          focusNode: focusNode,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: 'Nome do paciente',
            hintStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey[400],
            ),
            contentPadding: const EdgeInsets.only(bottom: 4),
            isDense: true,
            border: nameController.text.isEmpty && !focusNode.hasFocus
                ? UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  )
                : InputBorder.none,
            enabledBorder: nameController.text.isEmpty && !focusNode.hasFocus
                ? UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  )
                : InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: nameController.text.isEmpty && !focusNode.hasFocus
                ? UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  )
                : InputBorder.none,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Paciente ativo da pasta ${widget.clinicName}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
