import 'package:aurea_app/src/presentation/screens/patients_handle/models/photo_view_mode.dart';
import 'package:flutter/material.dart';

class PatientPhotoViewModeToggle extends StatelessWidget {
  final PhotoViewMode mode;
  final bool planningAvailable;
  final ValueChanged<PhotoViewMode> onChanged;

  const PatientPhotoViewModeToggle({
    super.key,
    required this.mode,
    required this.planningAvailable,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<PhotoViewMode>(
      segments: [
        const ButtonSegment(
          value: PhotoViewMode.original,
          label: Text('Original'),
          icon: Icon(Icons.image_outlined, size: 18),
        ),
        ButtonSegment(
          value: PhotoViewMode.planning,
          label: const Text('Planejamento'),
          icon: const Icon(Icons.auto_fix_high_outlined, size: 18),
          enabled: planningAvailable,
        ),
      ],
      selected: {mode},
      onSelectionChanged: (selection) {
        if (selection.isEmpty) return;
        onChanged(selection.first);
      },
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        textStyle: const WidgetStatePropertyAll(
          TextStyle(fontFamily: 'Montserrat', fontSize: 13),
        ),
      ),
    );
  }
}
