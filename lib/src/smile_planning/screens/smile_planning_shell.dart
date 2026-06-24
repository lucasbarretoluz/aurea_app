import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/smile_planning/cubit/smile_planning_cubit.dart';
import 'package:aurea_app/src/smile_planning/models/smile_planning_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SmilePlanningShell extends StatefulWidget {
  final Widget child;
  final PatientModel? patient;
  final int? clinicId;
  final String? clinicName;
  final List<String> photoUrls;
  final String? selectedPhotoUrl;

  const SmilePlanningShell({
    super.key,
    required this.child,
    this.patient,
    this.clinicId,
    this.clinicName,
    this.photoUrls = const [],
    this.selectedPhotoUrl,
  });

  @override
  State<SmilePlanningShell> createState() => _SmilePlanningShellState();
}

class _SmilePlanningShellState extends State<SmilePlanningShell> {
  SmilePlanningCubit? _cubit;

  @override
  void dispose() {
    _cubit?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final patient = widget.patient;
    if (patient == null) {
      return const Scaffold(
        body: Center(child: Text('Dados do paciente não encontrados')),
      );
    }

    _cubit ??= SmilePlanningCubit()
      ..startPlanning(
        patient: patient,
        photoUrls: widget.photoUrls,
        selectedPhotoUrl: widget.selectedPhotoUrl,
      );

    return BlocProvider<SmilePlanningCubit>.value(
      value: _cubit!,
      child: _StepSync(child: widget.child),
    );
  }
}

class _StepSync extends StatefulWidget {
  final Widget child;

  const _StepSync({required this.child});

  @override
  State<_StepSync> createState() => _StepSyncState();
}

class _StepSyncState extends State<_StepSync> {
  String? _lastLocation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final location = GoRouterState.of(context).uri.toString();
    if (_lastLocation == location) return;
    _lastLocation = location;

    final step = SmilePlanningStepRoutes.fromLocation(location);
    if (step != null) {
      context.read<SmilePlanningCubit>().resumeAtStep(step);
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

SmilePlanningLaunchData? parseSmilePlanningExtra(Object? extra) {
  if (extra is! Map<String, dynamic>) return null;
  final patient = extra['patient'];
  if (patient is! PatientModel) return null;

  final photoUrls = extra['photoUrls'];
  return SmilePlanningLaunchData(
    patient: patient,
    clinicId: extra['clinicId'] as int? ?? patient.clinicId,
    clinicName: extra['clinicName'] as String? ?? patient.clinicName,
    photoUrls:
        photoUrls is List
            ? photoUrls.whereType<String>().toList()
            : const <String>[],
    selectedPhotoUrl: extra['selectedPhotoUrl'] as String?,
  );
}

class SmilePlanningLaunchData {
  final PatientModel patient;
  final int clinicId;
  final String clinicName;
  final List<String> photoUrls;
  final String? selectedPhotoUrl;

  const SmilePlanningLaunchData({
    required this.patient,
    required this.clinicId,
    required this.clinicName,
    required this.photoUrls,
    this.selectedPhotoUrl,
  });
}
