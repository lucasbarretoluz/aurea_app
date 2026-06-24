import 'package:aurea_app/src/smile_planning/cubit/smile_planning_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FaceCalibrationNavigation {
  const FaceCalibrationNavigation._();

  static void goBack(BuildContext context) {
    final previousRoute = context.read<SmilePlanningCubit>().previousStep();
    if (previousRoute != null && context.mounted) {
      context.go(previousRoute);
      return;
    }
    context.pop();
  }

  static Future<void> confirmAndAdvance(BuildContext context) async {
    final cubit = context.read<SmilePlanningCubit>();
    final nextRoute = await cubit.nextStep();
    if (!context.mounted) return;

    if (nextRoute != null) {
      context.go(nextRoute);
    }
  }
}
