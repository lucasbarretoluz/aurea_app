import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HandlePatientsPage extends StatelessWidget {
  final PatientModel patient;
  const HandlePatientsPage({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return HandlePatientsView(patient: patient);
  }
}

class HandlePatientsView extends StatefulWidget {
  final PatientModel patient;
  const HandlePatientsView({super.key, required this.patient});

  @override
  State<HandlePatientsView> createState() => _HandlePatientsViewState();
}

class _HandlePatientsViewState extends State<HandlePatientsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  child: Image.asset(
                    'assets/images/demo-man.png',
                    fit: BoxFit.fitHeight,
                    height: 530,
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 35,
                    ),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.patient.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Paciente ativo da pasta ${widget.patient.clinicName}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: double.infinity),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
