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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              enabled: widget.isActiveChangeName,
              controller: nameController,
              focusNode: focusNode,
              autofocus: true,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                hintText: 'Nome do paciente',
                hintStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                contentPadding: EdgeInsets.zero,
                isDense: true,
                isCollapsed: true,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ],
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
