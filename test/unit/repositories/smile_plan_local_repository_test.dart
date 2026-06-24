import 'package:aurea_app/src/smile_planning/models/smile_plan.dart';
import 'package:aurea_app/src/smile_planning/models/smile_planning_step.dart';
import 'package:aurea_app/src/smile_planning/repository/smile_plan_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SmilePlanLocalRepository', () {
    late SmilePlanLocalRepository repository;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      repository = SmilePlanLocalRepository();
    });

    SmilePlan buildPlan({
      required String id,
      String photoUrl = 'https://example.com/photo.jpg',
    }) {
      final now = DateTime(2025, 6, 1);
      return SmilePlan(
        id: id,
        patientId: 42,
        photoUrl: photoUrl,
        currentStep: SmilePlanningStep.faceCenter,
        createdAt: now,
        updatedAt: now,
      );
    }

    test('save and loadForPhoto round-trip', () async {
      final plan = buildPlan(id: 'plan-1');

      await repository.save(plan);
      final loaded = await repository.loadForPhoto(
        42,
        'https://example.com/photo.jpg',
      );

      expect(loaded, isNotNull);
      expect(loaded!.id, 'plan-1');
    });

    test('listByPatient returns multiple plans', () async {
      await repository.save(
        buildPlan(id: 'plan-a', photoUrl: 'https://example.com/a.jpg'),
      );
      await repository.save(
        buildPlan(id: 'plan-b', photoUrl: 'https://example.com/b.jpg'),
      );

      final plans = await repository.listByPatient(42);

      expect(plans, hasLength(2));
    });

    test('save upserts plan for same photo url', () async {
      await repository.save(
        buildPlan(id: 'plan-1', photoUrl: 'https://example.com/a.jpg'),
      );
      final updated = buildPlan(
        id: 'plan-2',
        photoUrl: 'https://example.com/a.jpg',
      ).copyWith(currentStep: SmilePlanningStep.faceMidline);

      await repository.save(updated);

      final plans = await repository.listByPatient(42);
      expect(plans, hasLength(1));
      expect(plans.first.id, 'plan-2');
      expect(plans.first.currentStep, SmilePlanningStep.faceMidline);
    });

    test('delete removes plan by id', () async {
      final plan = buildPlan(id: 'plan-delete');
      await repository.save(plan);

      await repository.delete('plan-delete');

      final loaded = await repository.loadForPhoto(
        42,
        'https://example.com/photo.jpg',
      );
      expect(loaded, isNull);
    });

    test('migrates legacy single-plan storage', () async {
      final legacyPlan = buildPlan(id: 'legacy-plan');
      SharedPreferences.setMockInitialValues({
        'smile_plan_42': '''
{"id":"legacy-plan","patientId":42,"photoUrl":"https://example.com/photo.jpg","referenceLines":{"faceLines":[],"smileLines":[]},"toothShape":"oval","toothAdjustments":[],"currentStep":"faceCenter","syncStatus":"localOnly","createdAt":"2025-06-01T00:00:00.000","updatedAt":"2025-06-01T00:00:00.000"}
''',
      });
      repository = SmilePlanLocalRepository();

      final plans = await repository.listByPatient(42);

      expect(plans, hasLength(1));
      expect(plans.first.id, 'legacy-plan');
    });
  });
}
