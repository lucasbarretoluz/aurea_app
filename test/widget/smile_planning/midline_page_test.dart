import 'package:aurea_app/src/data/models/patient/patient_model.dart';
import 'package:aurea_app/src/smile_planning/cubit/smile_planning_cubit.dart';
import 'package:aurea_app/src/smile_planning/models/smile_planning_step.dart';
import 'package:aurea_app/src/smile_planning/repository/smile_plan_repository.dart';
import 'package:aurea_app/src/smile_planning/screens/face_calibration/midline_page.dart';
import 'package:aurea_app/src/smile_planning/widgets/planning_step_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSmilePlanRepository extends Mock implements SmilePlanRepository {}

void main() {
  late SmilePlanningCubit cubit;

  setUp(() {
    final repository = MockSmilePlanRepository();
    when(() => repository.loadActive(any())).thenAnswer((_) async => null);
    cubit = SmilePlanningCubit(repository: repository);
  });

  tearDown(() {
    cubit.close();
  });

  testWidgets('MidlinePage renders instruction footer', (
    WidgetTester tester,
  ) async {
    await cubit.startPlanning(
      patient: PatientModel(
        patientId: 1,
        name: 'Ana',
        createdAt: DateTime(2025, 1, 1),
        updatedAt: DateTime(2025, 1, 1),
      ),
      photoUrls: const ['https://example.com/photo.jpg'],
      initialStep: SmilePlanningStep.faceMidline,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<SmilePlanningCubit>.value(
          value: cubit,
          child: const MidlinePage(),
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(PlanningStepFooter), findsOneWidget);
    expect(find.text('Design do Sorriso'), findsOneWidget);
  });
}
