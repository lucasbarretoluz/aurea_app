import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final bool isDisabled;
  final TextStyle? textStyle;
  final Color? textColor;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final double? borderRadius;

  const LoadingButton({
    super.key,
    this.onPressed,
    required this.text,
    this.isLoading = false,
    this.isDisabled = false,
    this.textStyle,
    this.textColor,
    this.height,
    this.width,
    this.backgroundColor,
    this.borderRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 45.0,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Color(0xffefefef),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 20),
          ),
          padding: EdgeInsets.zero,
        ),
        onPressed: isDisabled ? null : onPressed,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            : Text(
                text,
                textAlign: TextAlign.center,
                style:
                    textStyle ??
                    TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: textColor ?? Colors.black,
                    ),
              ),
      ),
    );
  }
}
