import 'package:aurea_app/src/presentation/screens/home/widgets/create_clinic_dialog.dart';
import 'package:aurea_app/src/presentation/widgets/buttons/loading_button.dart';
import 'package:flutter/material.dart';

class EmptyClinicState extends StatelessWidget {
  final bool isLoading;
  final Future<void> Function(String name) onCreateClinic;

  const EmptyClinicState({
    super.key,
    required this.isLoading,
    required this.onCreateClinic,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_hospital_outlined,
              size: 72,
              color: colorScheme.primary.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 24),
            const Text(
              'Nenhuma clínica encontrada',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Crie sua primeira clínica para cadastrar pacientes e iniciar planejamentos.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurface.withValues(alpha: 0.65),
                fontFamily: 'Montserrat',
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),
            LoadingButton(
              text: 'Criar clínica',
              isLoading: isLoading,
              isDisabled: isLoading,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              height: 48,
              width: 220,
              borderRadius: 24,
              onPressed: () async {
                final name = await showDialog<String>(
                  context: context,
                  builder: (context) => const CreateClinicDialog(),
                );
                if (name != null && name.isNotEmpty) {
                  await onCreateClinic(name);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
