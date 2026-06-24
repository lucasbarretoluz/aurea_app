import 'package:aurea_app/src/smile_planning/cubit/smile_planning_cubit.dart';
import 'package:aurea_app/src/smile_planning/models/image_transform.dart';
import 'package:aurea_app/src/smile_planning/models/line_transform.dart';
import 'package:aurea_app/src/smile_planning/models/reference_line_type.dart';
import 'package:aurea_app/src/smile_planning/models/smile_planning_step.dart';
import 'package:aurea_app/src/smile_planning/screens/face_calibration/face_calibration_navigation.dart';
import 'package:aurea_app/src/smile_planning/screens/face_calibration/face_calibration_scaffold.dart';
import 'package:aurea_app/src/smile_planning/utils/reference_line_utils.dart';
import 'package:aurea_app/src/smile_planning/widgets/draggable_line_overlay.dart';
import 'package:aurea_app/src/smile_planning/widgets/planning_toolbar.dart';
import 'package:aurea_app/src/smile_planning/widgets/smile_canvas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaceLineCalibrationPage extends StatefulWidget {
  final SmilePlanningStep step;
  final ReferenceLineType lineType;

  const FaceLineCalibrationPage({
    super.key,
    required this.step,
    required this.lineType,
  });

  @override
  State<FaceLineCalibrationPage> createState() => _FaceLineCalibrationPageState();
}

class _FaceLineCalibrationPageState extends State<FaceLineCalibrationPage> {
  Size? _canvasSize;

  void _onTransformChanged(LineTransform transform) {
    context.read<SmilePlanningCubit>().updateLine(
      type: widget.lineType,
      phase: CalibrationPhase.face,
      transform: transform,
    );
  }

  Future<void> _onConfirm() async {
    final cubit = context.read<SmilePlanningCubit>();
    final state = cubit.state;
    if (state is SmilePlanningStepActive) {
      final transform = ReferenceLineUtils.resolveTransform(
        referenceLines: state.plan.referenceLines,
        type: widget.lineType,
        phase: CalibrationPhase.face,
      );
      cubit.updateLine(
        type: widget.lineType,
        phase: CalibrationPhase.face,
        transform: transform,
      );
    }

    await FaceCalibrationNavigation.confirmAndAdvance(context);
  }

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
        final activeTransform = ReferenceLineUtils.resolveTransform(
          referenceLines: state.plan.referenceLines,
          type: widget.lineType,
          phase: CalibrationPhase.face,
        );
        final displayedLines = ReferenceLineUtils.buildFaceDisplayedLines(
          referenceLines: state.plan.referenceLines,
          activeType: widget.lineType,
          activeTransform: activeTransform,
        );

        final canvas =
            photoUrl.isEmpty
                ? const Center(child: Text('Nenhuma foto disponível'))
                : SmileCanvas(
                  imageProvider: NetworkImage(photoUrl),
                  frozenImageTransform:
                      state.plan.imageTransform ?? const ImageTransform(),
                  onCanvasSizeChanged: (size) {
                    if (_canvasSize != size) {
                      setState(() => _canvasSize = size);
                    }
                  },
                  overlay:
                      _canvasSize == null
                          ? null
                          : Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              DraggableLineOverlay(
                                canvasSize: _canvasSize!,
                                lines: displayedLines,
                                activeIndex: displayedLines.length - 1,
                                onTransformChanged: _onTransformChanged,
                              ),
                              PlanningToolbar(
                                onReset:
                                    () =>
                                        context
                                            .read<SmilePlanningCubit>()
                                            .resetCurrentStep(),
                                onConfirm: _onConfirm,
                              ),
                            ],
                          ),
                );

        return FaceCalibrationScaffold(
          step: widget.step,
          onBack: () => FaceCalibrationNavigation.goBack(context),
          canvas: canvas,
        );
      },
    );
  }
}
