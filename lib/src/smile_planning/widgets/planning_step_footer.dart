import 'package:aurea_app/src/smile_planning/models/smile_planning_step.dart';
import 'package:aurea_app/src/smile_planning/widgets/planning_step_instructions.dart';
import 'package:flutter/material.dart';

class PlanningStepFooter extends StatelessWidget {
  final String prefix;
  final String highlight;
  final String suffix;

  const PlanningStepFooter({
    super.key,
    required this.prefix,
    required this.highlight,
    this.suffix = '',
  });

  factory PlanningStepFooter.forStep(SmilePlanningStep step) {
    final instruction = PlanningStepInstructions.forStep(step);
    return PlanningStepFooter(
      prefix: instruction.prefix,
      highlight: instruction.highlight,
      suffix: instruction.suffix,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontFamily: 'Montserrat',
            height: 1.4,
          ),
          children: [
            TextSpan(text: prefix),
            TextSpan(
              text: highlight,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            if (suffix.isNotEmpty) TextSpan(text: suffix),
          ],
        ),
      ),
    );
  }
}
