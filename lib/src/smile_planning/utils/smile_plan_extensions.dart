import 'package:aurea_app/src/smile_planning/models/smile_plan.dart';
import 'package:aurea_app/src/smile_planning/models/smile_planning_step.dart';

extension SmilePlanStatus on SmilePlan {
  bool get isCompleted => completedAt != null;

  bool get hasStarted =>
      currentStep != SmilePlanningStep.faceCenter ||
      imageTransform != null ||
      referenceLines.faceLines.isNotEmpty ||
      referenceLines.smileLines.isNotEmpty ||
      curve != null;
}
