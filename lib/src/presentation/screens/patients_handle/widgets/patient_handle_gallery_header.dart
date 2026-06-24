import 'package:aurea_app/src/presentation/screens/patients_handle/widgets/patient_handle_back_button.dart';
import 'package:aurea_app/src/presentation/screens/patients_handle/widgets/patient_handle_photo_menu_button.dart';
import 'package:flutter/material.dart';

class PatientHandleGalleryHeader extends StatelessWidget {
  final bool showMenuButton;
  final VoidCallback? onMenuPressed;

  const PatientHandleGalleryHeader({
    super.key,
    required this.showMenuButton,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const PatientHandleBackButton(),
          if (showMenuButton)
            PatientHandlePhotoMenuButton(onPressed: onMenuPressed)
          else
            const SizedBox(width: 40, height: 40),
        ],
      ),
    );
  }
}
