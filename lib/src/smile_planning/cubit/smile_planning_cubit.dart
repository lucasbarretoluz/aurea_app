import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/smile_planning/models/curve_data.dart';
import 'package:aurea_app/src/smile_planning/models/image_transform.dart';
import 'package:aurea_app/src/smile_planning/models/line_transform.dart';
import 'package:aurea_app/src/smile_planning/models/reference_line.dart';
import 'package:aurea_app/src/smile_planning/models/reference_line_type.dart';
import 'package:aurea_app/src/smile_planning/models/reference_lines.dart';
import 'package:aurea_app/src/smile_planning/models/smile_plan.dart';
import 'package:aurea_app/src/smile_planning/models/smile_planning_step.dart';
import 'package:aurea_app/src/smile_planning/models/tooth_adjustment.dart';
import 'package:aurea_app/src/smile_planning/models/tooth_shape.dart';
import 'package:aurea_app/src/smile_planning/repository/smile_plan_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'smile_planning_state.dart';
part 'smile_planning_cubit.freezed.dart';

class SmilePlanningCubit extends Cubit<SmilePlanningState> {
  SmilePlanningCubit({SmilePlanRepository? repository})
    : _repository = repository ?? SmilePlanLocalRepository(),
      super(const SmilePlanningState.initial());

  final SmilePlanRepository _repository;

  Future<void> startPlanning({
    required PatientModel patient,
    required List<String> photoUrls,
    String? selectedPhotoUrl,
    SmilePlanningStep initialStep = SmilePlanningStep.faceCenter,
  }) async {
    try {
      final defaultPhoto = photoUrls.isNotEmpty ? photoUrls.first : '';
      final activePhoto =
          selectedPhotoUrl != null && selectedPhotoUrl.isNotEmpty
              ? selectedPhotoUrl
              : defaultPhoto;

      final existing =
          activePhoto.isNotEmpty
              ? await _repository.loadForPhoto(patient.patientId, activePhoto)
              : await _repository.loadActive(patient.patientId);

      final now = DateTime.now();
      final resumeStep =
          existing != null && existing.completedAt == null
              ? existing.currentStep
              : initialStep;

      final plan =
          existing?.copyWith(
            photoUrl: activePhoto,
            currentStep: resumeStep,
            updatedAt: now,
          ) ??
          SmilePlan(
            id: '${patient.patientId}_${activePhoto.hashCode}_${now.millisecondsSinceEpoch}',
            patientId: patient.patientId,
            photoUrl: activePhoto,
            imageTransform: const ImageTransform(),
            currentStep: initialStep,
            createdAt: now,
            updatedAt: now,
          );

      emit(
        SmilePlanningState.stepActive(
          step: resumeStep,
          plan: plan,
          photoUrls: photoUrls,
          activePhotoUrl: activePhoto,
        ),
      );
    } catch (e) {
      emit(SmilePlanningState.error(message: 'Erro ao iniciar planejamento'));
    }
  }

  Future<void> resumeAtStep(SmilePlanningStep step) async {
    final current = state;
    if (current is! SmilePlanningStepActive) return;
    emit(current.copyWith(step: step, plan: current.plan.copyWith(currentStep: step)));
  }

  Future<String?> nextStep() async {
    final current = state;
    if (current is! SmilePlanningStepActive) return null;

    if (!_canAdvance(current)) {
      emit(
        const SmilePlanningState.error(
          message: 'Complete o passo atual antes de continuar',
        ),
      );
      emit(current);
      return null;
    }

    final next = current.step.next;
    if (next == null) {
      await _completePlan(current);
      return null;
    }

    emit(const SmilePlanningState.saving());
    final updatedPlan = current.plan.copyWith(
      currentStep: next,
      updatedAt: DateTime.now(),
    );
    await _repository.save(updatedPlan);

    final nextState = SmilePlanningState.stepActive(
      step: next,
      plan: updatedPlan,
      photoUrls: current.photoUrls,
      activePhotoUrl: current.activePhotoUrl,
    );
    emit(nextState);
    return next.routePath;
  }

  String? previousStep() {
    final current = state;
    if (current is! SmilePlanningStepActive) return null;
    final prev = current.step.previous;
    if (prev == null) return null;

    emit(
      current.copyWith(step: prev, plan: current.plan.copyWith(currentStep: prev)),
    );
    return prev.routePath;
  }

  void updateLine({
    required ReferenceLineType type,
    required CalibrationPhase phase,
    required LineTransform transform,
  }) {
    final current = state;
    if (current is! SmilePlanningStepActive) return;

    final lines = current.plan.referenceLines;
    final updatedLine = ReferenceLine(
      type: type,
      phase: phase,
      transform: transform,
    );

    ReferenceLines updatedLines;
    if (phase == CalibrationPhase.face) {
      updatedLines = lines.copyWith(
        faceLines: _upsertLine(lines.faceLines, updatedLine),
      );
    } else {
      updatedLines = lines.copyWith(
        smileLines: _upsertLine(lines.smileLines, updatedLine),
      );
    }

    emit(
      current.copyWith(
        plan: current.plan.copyWith(
          referenceLines: updatedLines,
          updatedAt: DateTime.now(),
        ),
      ),
    );
  }

  void updateImageTransform(ImageTransform transform) {
    final current = state;
    if (current is! SmilePlanningStepActive) return;
    emit(
      current.copyWith(
        plan: current.plan.copyWith(
          imageTransform: transform,
          updatedAt: DateTime.now(),
        ),
      ),
    );
  }

  void updateCurve(CurveData curve) {
    final current = state;
    if (current is! SmilePlanningStepActive) return;
    emit(
      current.copyWith(
        plan: current.plan.copyWith(
          curve: curve,
          updatedAt: DateTime.now(),
        ),
      ),
    );
  }

  void selectReferencePhoto(String url) {
    final current = state;
    if (current is! SmilePlanningStepActive) return;
    emit(
      current.copyWith(
        activePhotoUrl: url,
        plan: current.plan.copyWith(photoUrl: url, updatedAt: DateTime.now()),
      ),
    );
  }

  void selectToothShape(ToothShape shape) {
    final current = state;
    if (current is! SmilePlanningStepActive) return;
    emit(
      current.copyWith(
        plan: current.plan.copyWith(toothShape: shape, updatedAt: DateTime.now()),
      ),
    );
  }

  void updateToothAdjustment(int index, ToothAdjustment adjustment) {
    final current = state;
    if (current is! SmilePlanningStepActive) return;

    final adjustments = [...current.plan.toothAdjustments];
    final existingIndex = adjustments.indexWhere((a) => a.toothIndex == index);
    if (existingIndex >= 0) {
      adjustments[existingIndex] = adjustment;
    } else {
      adjustments.add(adjustment);
    }

    emit(
      current.copyWith(
        plan: current.plan.copyWith(
          toothAdjustments: adjustments,
          updatedAt: DateTime.now(),
        ),
      ),
    );
  }

  void selectVeneerStyle(String styleId) {
    final current = state;
    if (current is! SmilePlanningStepActive) return;
    emit(
      current.copyWith(
        plan: current.plan.copyWith(
          veneerStyleId: styleId,
          updatedAt: DateTime.now(),
        ),
      ),
    );
  }

  void resetCurrentStep() {
    final current = state;
    if (current is! SmilePlanningStepActive) return;

    switch (current.step) {
      case SmilePlanningStep.faceCenter:
        emit(
          current.copyWith(
            plan: current.plan.copyWith(
              imageTransform: const ImageTransform(),
              updatedAt: DateTime.now(),
            ),
          ),
        );
      case SmilePlanningStep.faceMidline:
        _resetLine(current, ReferenceLineType.midline, CalibrationPhase.face);
      case SmilePlanningStep.faceBipupillary:
        _resetLine(current, ReferenceLineType.bipupillary, CalibrationPhase.face);
      case SmilePlanningStep.faceHighSmileLine:
        _resetLine(
          current,
          ReferenceLineType.highSmileLine,
          CalibrationPhase.face,
        );
      case SmilePlanningStep.smileMidline:
        _resetLine(current, ReferenceLineType.midline, CalibrationPhase.smile);
      case SmilePlanningStep.smileHighLine:
        _resetLine(
          current,
          ReferenceLineType.highSmileLine,
          CalibrationPhase.smile,
        );
      case SmilePlanningStep.smileCurve:
        emit(
          current.copyWith(
            plan: current.plan.copyWith(
              curve: null,
              updatedAt: DateTime.now(),
            ),
          ),
        );
      default:
        break;
    }
  }

  Future<void> persistCurrentPlan() async {
    final current = state;
    if (current is! SmilePlanningStepActive) return;
    await _repository.save(current.plan);
  }

  bool _canAdvance(SmilePlanningStepActive current) {
    switch (current.step) {
      case SmilePlanningStep.faceCenter:
        return current.plan.imageTransform != null;
      case SmilePlanningStep.faceMidline:
        return _hasLine(
          current.plan.referenceLines,
          ReferenceLineType.midline,
          CalibrationPhase.face,
        );
      case SmilePlanningStep.faceBipupillary:
        return _hasLine(
          current.plan.referenceLines,
          ReferenceLineType.bipupillary,
          CalibrationPhase.face,
        );
      case SmilePlanningStep.faceHighSmileLine:
        return _hasLine(
          current.plan.referenceLines,
          ReferenceLineType.highSmileLine,
          CalibrationPhase.face,
        );
      case SmilePlanningStep.smilePhotoSelect:
        return current.activePhotoUrl.isNotEmpty;
      case SmilePlanningStep.smileMidline:
        return _hasLine(
          current.plan.referenceLines,
          ReferenceLineType.midline,
          CalibrationPhase.smile,
        );
      case SmilePlanningStep.smileHighLine:
        return _hasLine(
          current.plan.referenceLines,
          ReferenceLineType.highSmileLine,
          CalibrationPhase.smile,
        );
      case SmilePlanningStep.smileCurve:
        return current.plan.curve != null &&
            current.plan.curve!.controlPoints.length >= 3;
      case SmilePlanningStep.designShape:
        return true;
      case SmilePlanningStep.designAdjust:
        return true;
      case SmilePlanningStep.designVeneer:
        return current.plan.veneerStyleId != null;
      case SmilePlanningStep.designResult:
        return true;
    }
  }

  Future<void> _completePlan(SmilePlanningStepActive current) async {
    emit(const SmilePlanningState.saving());
    final completed = current.plan.copyWith(
      completedAt: DateTime.now(),
      updatedAt: DateTime.now(),
      currentStep: SmilePlanningStep.designResult,
    );
    await _repository.save(completed);
    emit(SmilePlanningState.completed(plan: completed));
  }

  void _resetLine(
    SmilePlanningStepActive current,
    ReferenceLineType type,
    CalibrationPhase phase,
  ) {
    final lines = current.plan.referenceLines;
    if (phase == CalibrationPhase.face) {
      emit(
        current.copyWith(
          plan: current.plan.copyWith(
            referenceLines: lines.copyWith(
              faceLines:
                  lines.faceLines
                      .where((line) => line.type != type)
                      .toList(),
            ),
            updatedAt: DateTime.now(),
          ),
        ),
      );
    } else {
      emit(
        current.copyWith(
          plan: current.plan.copyWith(
            referenceLines: lines.copyWith(
              smileLines:
                  lines.smileLines
                      .where((line) => line.type != type)
                      .toList(),
            ),
            updatedAt: DateTime.now(),
          ),
        ),
      );
    }
  }

  List<ReferenceLine> _upsertLine(
    List<ReferenceLine> lines,
    ReferenceLine line,
  ) {
    final updated = [...lines];
    final index = updated.indexWhere((item) => item.type == line.type);
    if (index >= 0) {
      updated[index] = line;
    } else {
      updated.add(line);
    }
    return updated;
  }

  bool _hasLine(
    ReferenceLines lines,
    ReferenceLineType type,
    CalibrationPhase phase,
  ) {
    final collection =
        phase == CalibrationPhase.face ? lines.faceLines : lines.smileLines;
    return collection.any((line) => line.type == type);
  }
}
