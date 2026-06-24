import 'package:aurea_app/src/smile_planning/cubit/smile_planning_cubit.dart';
import 'package:aurea_app/src/smile_planning/models/image_transform.dart';
import 'package:aurea_app/src/smile_planning/models/smile_planning_step.dart';
import 'package:aurea_app/src/smile_planning/screens/face_calibration/face_calibration_navigation.dart';
import 'package:aurea_app/src/smile_planning/screens/face_calibration/face_calibration_scaffold.dart';
import 'package:aurea_app/src/smile_planning/widgets/planning_toolbar.dart';
import 'package:aurea_app/src/smile_planning/widgets/smile_canvas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaceCenteringPage extends StatelessWidget {
  const FaceCenteringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmilePlanningCubit, SmilePlanningState>(
      builder: (context, state) {
        if (state is! SmilePlanningStepActive) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final photoUrl = state.activePhotoUrl;
        final canvas =
            photoUrl.isEmpty
                ? const Center(child: Text('Nenhuma foto disponível'))
                : SmileCanvas(
                  imageProvider: NetworkImage(photoUrl),
                  enablePanZoom: true,
                  panZoomTransform:
                      state.plan.imageTransform ?? const ImageTransform(),
                  onPanZoomChanged:
                      context
                          .read<SmilePlanningCubit>()
                          .updateImageTransform,
                  overlay: Align(
                    alignment: Alignment.bottomCenter,
                    child: PlanningToolbar(
                      onReset:
                          () =>
                              context
                                  .read<SmilePlanningCubit>()
                                  .resetCurrentStep(),
                      onConfirm:
                          () => FaceCalibrationNavigation.confirmAndAdvance(
                            context,
                          ),
                    ),
                  ),
                );

        return FaceCalibrationScaffold(
          step: SmilePlanningStep.faceCenter,
          onBack: () => FaceCalibrationNavigation.goBack(context),
          canvas: canvas,
        );
      },
    );
  }
}
