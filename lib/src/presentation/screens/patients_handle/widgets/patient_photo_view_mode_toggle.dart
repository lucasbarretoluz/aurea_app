import 'package:aurea_app/src/presentation/screens/patients_handle/models/photo_view_mode.dart';
import 'package:aurea_app/src/presentation/widgets/toast/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class PatientPhotoViewModeToggle extends StatelessWidget {
  static ToastificationItem? _planningUnavailableToast;

  final PhotoViewMode mode;
  final bool planningAvailable;
  final ValueChanged<PhotoViewMode> onChanged;

  const PatientPhotoViewModeToggle({
    super.key,
    required this.mode,
    required this.planningAvailable,
    required this.onChanged,
  });

  void _showPlanningUnavailableToast(BuildContext context) {
    final activeToast = _planningUnavailableToast;
    if (activeToast != null &&
        toastification.findToastificationItem(activeToast.id) != null) {
      return;
    }

    void clearActiveToast(ToastificationItem _) {
      _planningUnavailableToast = null;
    }

    _planningUnavailableToast = showToast(
      context: context,
      title: 'Sorriso ainda não planejado',
      description: 'Esta foto ainda não tem planejamento de sorriso.',
      type: ToastificationType.info,
      autoCloseDuration: const Duration(seconds: 3),
      callbacks: ToastificationCallbacks(
        onAutoCompleteCompleted: clearActiveToast,
        onDismissed: clearActiveToast,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<PhotoViewMode>(
      segments: [
        const ButtonSegment(
          value: PhotoViewMode.original,
          label: Text('Original'),
          icon: Icon(Icons.image_outlined, size: 18),
        ),
        const ButtonSegment(
          value: PhotoViewMode.planning,
          label: Text('Planejamento'),
          icon: Icon(Icons.auto_fix_high_outlined, size: 18),
        ),
      ],
      selected: {mode},
      onSelectionChanged: (selection) {
        if (selection.isEmpty) return;
        final selected = selection.first;
        if (selected == PhotoViewMode.planning && !planningAvailable) {
          _showPlanningUnavailableToast(context);
          return;
        }
        onChanged(selected);
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
