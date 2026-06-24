import 'package:aurea_app/src/smile_planning/cubit/smile_planning_cubit.dart';
import 'package:aurea_app/src/smile_planning/models/line_transform.dart';
import 'package:aurea_app/src/smile_planning/models/reference_line_type.dart';
import 'package:aurea_app/src/smile_planning/models/smile_planning_step.dart';
import 'package:aurea_app/src/smile_planning/widgets/smile_canvas.dart';
import 'package:aurea_app/src/presentation/widgets/buttons/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SmilePlanningStepPage extends StatelessWidget {
  final SmilePlanningStep step;

  const SmilePlanningStepPage({super.key, required this.step});

  Future<void> _onConfirm(BuildContext context) async {
    final cubit = context.read<SmilePlanningCubit>();
    _prepareStepData(cubit);
    final nextRoute = await cubit.nextStep();
    if (!context.mounted) return;

    if (nextRoute != null) {
      context.go(nextRoute);
      return;
    }

    final state = cubit.state;
    if (state is SmilePlanningCompleted) {
      context.pop();
    }
  }

  void _prepareStepData(SmilePlanningCubit cubit) {
    switch (step) {
      case SmilePlanningStep.faceMidline:
        cubit.updateLine(
          type: ReferenceLineType.midline,
          phase: CalibrationPhase.face,
          transform: const LineTransform(),
        );
      case SmilePlanningStep.faceBipupillary:
        cubit.updateLine(
          type: ReferenceLineType.bipupillary,
          phase: CalibrationPhase.face,
          transform: const LineTransform(),
        );
      case SmilePlanningStep.faceHighSmileLine:
        cubit.updateLine(
          type: ReferenceLineType.highSmileLine,
          phase: CalibrationPhase.face,
          transform: const LineTransform(),
        );
      case SmilePlanningStep.smileMidline:
        cubit.updateLine(
          type: ReferenceLineType.midline,
          phase: CalibrationPhase.smile,
          transform: const LineTransform(),
        );
      case SmilePlanningStep.smileHighLine:
        cubit.updateLine(
          type: ReferenceLineType.highSmileLine,
          phase: CalibrationPhase.smile,
          transform: const LineTransform(),
        );
      case SmilePlanningStep.smileCurve:
        cubit.updateLine(
          type: ReferenceLineType.smileCurve,
          phase: CalibrationPhase.smile,
          transform: const LineTransform(),
        );
      case SmilePlanningStep.designVeneer:
        cubit.selectVeneerStyle('default');
      default:
        break;
    }
  }

  void _onBack(BuildContext context) {
    final previousRoute = context.read<SmilePlanningCubit>().previousStep();
    if (previousRoute != null && context.mounted) {
      context.go(previousRoute);
      return;
    }
    context.pop();
  }

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

        final photoUrl = state.activePhotoUrl;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Design do Sorriso',
              style: const TextStyle(fontFamily: 'Montserrat'),
            ),
            leading: BackButton(onPressed: () => _onBack(context)),
          ),
          body: Column(
            children: [
              Expanded(
                child:
                    photoUrl.isNotEmpty
                        ? SmileCanvas(
                          imageProvider: NetworkImage(photoUrl),
                        )
                        : const Center(
                          child: Text('Nenhuma foto disponível'),
                        ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Text(
                  step.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: LoadingButton(
                  text: 'Confirmar',
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  onPressed: () => _onConfirm(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
