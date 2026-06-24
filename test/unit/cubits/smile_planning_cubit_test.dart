import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/smile_planning/cubit/smile_planning_cubit.dart';
import 'package:aurea_app/src/smile_planning/models/image_transform.dart';
import 'package:aurea_app/src/smile_planning/models/line_transform.dart';
import 'package:aurea_app/src/smile_planning/models/reference_line_type.dart';
import 'package:aurea_app/src/smile_planning/models/smile_plan.dart';
import 'package:aurea_app/src/smile_planning/models/smile_planning_step.dart';
import 'package:aurea_app/src/smile_planning/repository/smile_plan_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSmilePlanRepository extends Mock implements SmilePlanRepository {}

SmilePlan _fallbackPlan() {
  final now = DateTime(2025, 1, 1);
  return SmilePlan(
    id: 'fallback',
    patientId: 0,
    createdAt: now,
    updatedAt: now,
  );
}

void main() {
  setUpAll(() {
    registerFallbackValue(_fallbackPlan());
  });
  late MockSmilePlanRepository repository;
  late SmilePlanningCubit cubit;

  final patient = PatientModel(
    patientId: 1,
    clinicId: 10,
    name: 'Ana',
    clinicName: 'Clínica',
    createdAt: DateTime(2025, 1, 1),
    updatedAt: DateTime(2025, 1, 1),
  );

  setUp(() {
    repository = MockSmilePlanRepository();
    when(() => repository.loadForPhoto(any(), any())).thenAnswer((_) async => null);
    when(() => repository.loadActive(any())).thenAnswer((_) async => null);
    cubit = SmilePlanningCubit(repository: repository);
  });

  tearDown(() {
    cubit.close();
  });

  group('SmilePlanningCubit', () {
    test('initial state is initial', () {
      expect(cubit.state, const SmilePlanningState.initial());
    });

    test('startPlanning emits stepActive with plan', () async {
      await cubit.startPlanning(
        patient: patient,
        photoUrls: const ['https://example.com/photo.jpg'],
      );

      final state = cubit.state;
      expect(state, isA<SmilePlanningStepActive>());
      final active = state as SmilePlanningStepActive;
      expect(active.step, SmilePlanningStep.faceCenter);
      expect(active.plan.patientId, 1);
      expect(active.activePhotoUrl, 'https://example.com/photo.jpg');
    });

    test('nextStep advances to faceMidline and saves', () async {
      when(() => repository.save(any())).thenAnswer((_) async {});

      await cubit.startPlanning(
        patient: patient,
        photoUrls: const ['https://example.com/photo.jpg'],
      );

      final nextRoute = await cubit.nextStep();

      expect(nextRoute, '/smile-planning/face/midline');
      expect(cubit.state, isA<SmilePlanningStepActive>());
      verify(() => repository.save(any(that: isA<SmilePlan>()))).called(1);
    });

    test('nextStep blocks when line is missing', () async {
      when(() => repository.save(any())).thenAnswer((_) async {});

      await cubit.startPlanning(
        patient: patient,
        photoUrls: const ['https://example.com/photo.jpg'],
        initialStep: SmilePlanningStep.faceMidline,
      );

      final nextRoute = await cubit.nextStep();

      expect(nextRoute, isNull);
      expect(cubit.state, isA<SmilePlanningStepActive>());
      final active = cubit.state as SmilePlanningStepActive;
      expect(active.step, SmilePlanningStep.faceMidline);
    });

    test('updateLine allows advancing from faceMidline', () async {
      when(() => repository.save(any())).thenAnswer((_) async {});

      await cubit.startPlanning(
        patient: patient,
        photoUrls: const ['https://example.com/photo.jpg'],
        initialStep: SmilePlanningStep.faceMidline,
      );

      cubit.updateLine(
        type: ReferenceLineType.midline,
        phase: CalibrationPhase.face,
        transform: const LineTransform(),
      );

      final nextRoute = await cubit.nextStep();

      expect(nextRoute, '/smile-planning/face/bipupillary');
    });

    test('previousStep returns previous route', () async {
      await cubit.startPlanning(
        patient: patient,
        photoUrls: const ['https://example.com/photo.jpg'],
        initialStep: SmilePlanningStep.faceMidline,
      );

      final previousRoute = cubit.previousStep();

      expect(previousRoute, '/smile-planning/face/center');
      expect(cubit.state, isA<SmilePlanningStepActive>());
      final active = cubit.state as SmilePlanningStepActive;
      expect(active.step, SmilePlanningStep.faceCenter);
    });

    test('updateImageTransform updates plan', () async {
      await cubit.startPlanning(
        patient: patient,
        photoUrls: const ['https://example.com/photo.jpg'],
      );

      const transform = ImageTransform(scale: 1.5);
      cubit.updateImageTransform(transform);

      final active = cubit.state as SmilePlanningStepActive;
      expect(active.plan.imageTransform, transform);
    });

    test('phase A advances through all face calibration steps', () async {
      when(() => repository.save(any())).thenAnswer((_) async {});

      await cubit.startPlanning(
        patient: patient,
        photoUrls: const ['https://example.com/photo.jpg'],
      );

      expect(
        await cubit.nextStep(),
        '/smile-planning/face/midline',
      );

      cubit.updateLine(
        type: ReferenceLineType.midline,
        phase: CalibrationPhase.face,
        transform: const LineTransform(),
      );
      expect(
        await cubit.nextStep(),
        '/smile-planning/face/bipupillary',
      );

      cubit.updateLine(
        type: ReferenceLineType.bipupillary,
        phase: CalibrationPhase.face,
        transform: const LineTransform(),
      );
      expect(
        await cubit.nextStep(),
        '/smile-planning/face/high-smile-line',
      );

      cubit.updateLine(
        type: ReferenceLineType.highSmileLine,
        phase: CalibrationPhase.face,
        transform: const LineTransform(),
      );
      expect(
        await cubit.nextStep(),
        '/smile-planning/smile/photo-select',
      );

      final active = cubit.state as SmilePlanningStepActive;
      expect(active.step, SmilePlanningStep.smilePhotoSelect);
      verify(() => repository.save(any())).called(4);
    });

    test('phase A back navigation preserves plan state', () async {
      await cubit.startPlanning(
        patient: patient,
        photoUrls: const ['https://example.com/photo.jpg'],
        initialStep: SmilePlanningStep.faceBipupillary,
      );

      cubit.updateLine(
        type: ReferenceLineType.midline,
        phase: CalibrationPhase.face,
        transform: const LineTransform(offsetX: 0.42),
      );
      cubit.updateLine(
        type: ReferenceLineType.bipupillary,
        phase: CalibrationPhase.face,
        transform: const LineTransform(offsetY: 0.35),
      );

      expect(
        cubit.previousStep(),
        '/smile-planning/face/midline',
      );

      final active = cubit.state as SmilePlanningStepActive;
      expect(active.step, SmilePlanningStep.faceMidline);
      expect(
        active.plan.referenceLines.faceLines,
        hasLength(2),
      );
    });
  });
}
