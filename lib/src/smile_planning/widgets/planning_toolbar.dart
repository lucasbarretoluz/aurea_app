import 'package:flutter/material.dart';

class PlanningToolbarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isDisabled;

  const PlanningToolbarButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: isDisabled ? null : onPressed,
        child: SizedBox(
          width: 48,
          height: 48,
          child: Icon(
            icon,
            color: isDisabled ? Colors.grey : Colors.black,
            size: 22,
          ),
        ),
      ),
    );
  }
}

class PlanningToolbar extends StatelessWidget {
  final VoidCallback onReset;
  final VoidCallback onConfirm;
  final bool isDisabled;

  const PlanningToolbar({
    super.key,
    required this.onReset,
    required this.onConfirm,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PlanningToolbarButton(
            icon: Icons.refresh,
            onPressed: onReset,
            isDisabled: isDisabled,
          ),
          const SizedBox(width: 20),
          PlanningToolbarButton(
            icon: Icons.check,
            onPressed: onConfirm,
            isDisabled: isDisabled,
          ),
        ],
      ),
    );
  }
}
