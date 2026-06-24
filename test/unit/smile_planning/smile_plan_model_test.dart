import 'package:aurea_app/src/smile_planning/models/image_transform.dart';
import 'package:aurea_app/src/smile_planning/models/smile_plan.dart';
import 'package:aurea_app/src/smile_planning/models/smile_planning_step.dart';
import 'package:aurea_app/src/smile_planning/models/tooth_shape.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SmilePlan', () {
    test('json serialize and deserialize round-trip', () {
      final now = DateTime(2025, 6, 17, 12, 0);
      final plan = SmilePlan(
        id: 'plan-json',
        patientId: 7,
        photoUrl: 'https://example.com/face.jpg',
        imageTransform: const ImageTransform(scale: 1.2),
        toothShape: ToothShape.triangular,
        veneerStyleId: 'veneer-1',
        currentStep: SmilePlanningStep.smileMidline,
        createdAt: now,
        updatedAt: now,
        completedAt: now,
      );

      final json = plan.toJson();
      final restored = SmilePlan.fromJson(json);

      expect(restored.id, plan.id);
      expect(restored.patientId, plan.patientId);
      expect(restored.photoUrl, plan.photoUrl);
      expect(restored.imageTransform?.scale, 1.2);
      expect(restored.toothShape, ToothShape.triangular);
      expect(restored.veneerStyleId, 'veneer-1');
      expect(restored.currentStep, SmilePlanningStep.smileMidline);
      expect(restored.createdAt, now);
      expect(restored.updatedAt, now);
      expect(restored.completedAt, now);
    });
  });
}
