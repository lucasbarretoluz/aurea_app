import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

ToastificationItem showToast({
  required BuildContext context,
  required String title,
  String description = '',
  Alignment alignment = Alignment.topCenter,
  ToastificationType? type = ToastificationType.success,
  Duration autoCloseDuration = const Duration(seconds: 4),
  ToastificationCallbacks callbacks = const ToastificationCallbacks(),
}) {
  final colorScheme = Theme.of(context).colorScheme;
  
  Color backgroundColor;
  Color iconColor;
  IconData iconData;
  
  switch (type) {
    case ToastificationType.success:
      backgroundColor = colorScheme.primary;
      iconColor = Colors.white;
      iconData = Icons.check_circle;
      break;
    case ToastificationType.error:
      backgroundColor = colorScheme.error;
      iconColor = Colors.white;
      iconData = Icons.error;
      break;
    case ToastificationType.warning:
      backgroundColor = const Color(0xFFFFA726);
      iconColor = Colors.white;
      iconData = Icons.warning;
      break;
    case ToastificationType.info:
      backgroundColor = colorScheme.tertiary;
      iconColor = Colors.white;
      iconData = Icons.info;
      break;
    default:
      backgroundColor = colorScheme.primary;
      iconColor = Colors.white;
      iconData = Icons.check_circle;
  }

  return toastification.show(
    context: context,
    type: type ?? ToastificationType.success,
    style: ToastificationStyle.minimal,
    autoCloseDuration: autoCloseDuration,
    alignment: alignment,
    callbacks: callbacks,
    showProgressBar: false,
    closeButtonShowType: CloseButtonShowType.none,
    dragToClose: true,
    pauseOnHover: true,
    applyBlurEffect: true,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.15),
        blurRadius: 20,
        offset: const Offset(0, 8),
        spreadRadius: 2,
      ),
    ],
    icon: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 24,
      ),
    ),
    backgroundColor: backgroundColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.2,
      ),
    ),
    description: description.isNotEmpty
        ? Text(
            description,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.9),
              height: 1.4,
            ),
          )
        : null,
  );
}
