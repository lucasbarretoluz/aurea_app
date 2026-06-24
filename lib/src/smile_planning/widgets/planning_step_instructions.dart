import 'package:aurea_app/src/smile_planning/models/smile_planning_step.dart';

class PlanningStepInstruction {
  final String prefix;
  final String highlight;
  final String suffix;

  const PlanningStepInstruction({
    required this.prefix,
    required this.highlight,
    this.suffix = '',
  });
}

class PlanningStepInstructions {
  const PlanningStepInstructions._();

  static PlanningStepInstruction forStep(SmilePlanningStep step) {
    switch (step) {
      case SmilePlanningStep.faceCenter:
        return const PlanningStepInstruction(
          prefix: 'Centralize o ',
          highlight: 'rosto do paciente',
        );
      case SmilePlanningStep.faceMidline:
        return const PlanningStepInstruction(
          prefix: 'Posicione a ',
          highlight: 'linha média',
        );
      case SmilePlanningStep.faceBipupillary:
        return const PlanningStepInstruction(
          prefix: 'Posicione a linha ',
          highlight: 'bipupilar',
        );
      case SmilePlanningStep.faceHighSmileLine:
        return const PlanningStepInstruction(
          prefix: 'Posicione a ',
          highlight: 'linha alta do sorriso',
        );
      case SmilePlanningStep.smilePhotoSelect:
        return const PlanningStepInstruction(
          prefix: 'Selecione a ',
          highlight: 'foto de referência',
        );
      case SmilePlanningStep.smileMidline:
        return const PlanningStepInstruction(
          prefix: 'Posicione a ',
          highlight: 'linha média',
        );
      case SmilePlanningStep.smileHighLine:
        return const PlanningStepInstruction(
          prefix: 'Posicione a ',
          highlight: 'linha alta do sorriso',
        );
      case SmilePlanningStep.smileCurve:
        return const PlanningStepInstruction(
          prefix: 'Posicione a ',
          highlight: 'curva do sorriso',
        );
      case SmilePlanningStep.designShape:
        return const PlanningStepInstruction(
          prefix: 'Selecione o ',
          highlight: 'formato dos dentes',
        );
      case SmilePlanningStep.designAdjust:
        return const PlanningStepInstruction(
          prefix: 'Ajuste os ',
          highlight: 'dentes',
        );
      case SmilePlanningStep.designVeneer:
        return const PlanningStepInstruction(
          prefix: 'Selecione o estilo de ',
          highlight: 'facetas',
        );
      case SmilePlanningStep.designResult:
        return const PlanningStepInstruction(
          prefix: 'Visualize o ',
          highlight: 'resultado',
        );
    }
  }
}
