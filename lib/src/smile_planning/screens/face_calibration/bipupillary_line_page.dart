import 'package:aurea_app/src/smile_planning/models/reference_line_type.dart';
import 'package:aurea_app/src/smile_planning/models/smile_planning_step.dart';
import 'package:aurea_app/src/smile_planning/screens/face_calibration/face_line_calibration_page.dart';
import 'package:flutter/material.dart';

class BipupillaryLinePage extends StatelessWidget {
  const BipupillaryLinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FaceLineCalibrationPage(
      step: SmilePlanningStep.faceBipupillary,
      lineType: ReferenceLineType.bipupillary,
    );
  }
}
