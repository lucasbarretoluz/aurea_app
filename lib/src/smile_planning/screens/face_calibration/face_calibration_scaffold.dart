import 'package:aurea_app/src/smile_planning/cubit/smile_planning_cubit.dart';
import 'package:aurea_app/src/smile_planning/models/smile_planning_step.dart';
import 'package:aurea_app/src/smile_planning/widgets/planning_step_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaceCalibrationScaffold extends StatelessWidget {
  final Widget canvas;
  final SmilePlanningStep step;
  final VoidCallback onBack;

  const FaceCalibrationScaffold({
    super.key,
    required this.canvas,
    required this.step,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmilePlanningCubit, SmilePlanningState>(
      builder: (context, state) {
        if (state is SmilePlanningSaving) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is! SmilePlanningStepActive) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Design do Sorriso',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            leading: BackButton(onPressed: onBack),
          ),
          body: Column(
            children: [
              Expanded(child: canvas),
              PlanningStepFooter.forStep(step),
            ],
          ),
        );
      },
    );
  }
}
