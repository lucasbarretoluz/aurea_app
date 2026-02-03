import 'package:aurea_app/src/logic/cubit/patient_photo/patient_photo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavePhotosButton extends StatelessWidget {
  final bool isNewPatient;
  final VoidCallback onPressed;
  final bool Function(PatientPhotoState) isUploadingState;

  const SavePhotosButton({
    super.key,
    required this.isNewPatient,
    required this.onPressed,
    required this.isUploadingState,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: BlocBuilder<PatientPhotoCubit, PatientPhotoState>(
          builder: (context, state) {
            final isUploading = isUploadingState(state);
            
            return isUploading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    isNewPatient ? 'Criar paciente e salvar fotos' : 'Salvar fotos',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  );
          },
        ),
      ),
    );
  }
}

