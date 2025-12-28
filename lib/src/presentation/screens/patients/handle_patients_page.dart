import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/presentation/widgets/buttons/card_button.dart';
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
  Widget _buildProfileImage() {
    final hasPhoto =
        widget.patient.profilePhotoUrl != null &&
        widget.patient.profilePhotoUrl!.isNotEmpty;

    if (hasPhoto) {
      return Image.network(
        widget.patient.profilePhotoUrl!,
        fit: BoxFit.fitHeight,
        height: 530,
        errorBuilder: (context, error, stackTrace) {
          return _buildEmptyState();
        },
      );
    }

    return _buildEmptyState();
  }

  Widget _buildEmptyState() {
    return Container(
      height: 530,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.add_photo_alternate_rounded,
                  size: 64,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Cadastrar fotos do paciente',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Adicione fotos do paciente para começar a planejar o sorriso do paciente',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                  child: _buildProfileImage(),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 35,
                      color:
                          (widget.patient.profilePhotoUrl != null &&
                                  widget.patient.profilePhotoUrl!.isNotEmpty)
                              ? Colors.white
                              : Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                  const SizedBox(height: 30),
                  CardButton(
                    title: 'Novo ',
                    titleBold: 'Projeto',
                    subtitle: 'Clique para iniciar um novo',
                    description: 'planejamento do sorriso',
                    onPressed: () => context.push('/handle-patients/new-patient'),
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
