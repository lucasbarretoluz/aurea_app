import 'package:flutter/material.dart';

class NavigationButtons extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final Color colorText;
  final Color colorIcon;
  final Color colorBackground;

  const NavigationButtons({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPrevious,
    required this.onNext,
    this.colorText = Colors.black,
    this.colorIcon = Colors.grey,
    this.colorBackground = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (currentPage > 0) ...[
          _NavigationButton(
            text: 'anterior',
            icon: Icons.chevron_left,
            onPressed: onPrevious,
            isLeft: true,
            colorText: colorText,
            colorIcon: colorIcon,
            colorBackground: colorBackground,
          ),
          const SizedBox(width: 16),
        ] else ...[
          const SizedBox(width: 16),
        ],
        _NavigationButton(
          text: currentPage == totalPages - 1 ? 'concluir' : 'próximo',
          icon: currentPage == totalPages - 1 ? Icons.check : Icons.chevron_right,
          onPressed: onNext,
          isLeft: false,
          colorText: colorText,
          colorIcon: colorIcon,
          colorBackground: colorBackground,
        ),
      ],
    );
  }
}

class _NavigationButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isLeft;
  final Color colorText;
  final Color colorIcon;
  final Color colorBackground;

  const _NavigationButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.isLeft,
    required this.colorText,
    required this.colorIcon,
    required this.colorBackground,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: isLeft ? Radius.zero : Radius.circular(20),
              topRight: isLeft ? Radius.circular(20) : Radius.zero,
              bottomLeft: isLeft ? Radius.zero : Radius.circular(20),
              bottomRight: isLeft ? Radius.circular(20) : Radius.zero,
            ),
          ),
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 45),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLeft) ...[
                Icon(icon, color: colorIcon, size: 26),
                const SizedBox(width: 8),
              ],
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: colorText,
                  ),
                ),
              ),
              if (!isLeft) ...[
                const SizedBox(width: 8),

                Icon(icon, color: colorIcon, size: 26),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
