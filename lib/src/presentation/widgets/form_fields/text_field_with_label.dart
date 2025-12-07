import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWithLabel extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool? enabled;
  final bool? autofocus;
  final TextAlign textAlign;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final AutovalidateMode? autovalidateMode;
  final bool hideErrorText;
  final bool hasError;
  final String? errorText;
  final Color? fillColor;
  final String? suffixText;
  final Color? colorLabel;
  final TextStyle? styleLabel;
  final Color? iconColor;

  const TextFieldWithLabel({
    super.key,
    this.controller,
    this.label,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.enabled,
    this.autofocus,
    this.textAlign = TextAlign.start,
    this.onChanged,
    this.textInputAction,
    this.inputFormatters,
    this.hint,
    this.focusNode,
    this.suffixIcon,
    this.autovalidateMode,
    this.hideErrorText = false,
    this.hasError = false,
    this.errorText,
    this.fillColor,
    this.suffixText,
    this.colorLabel,
    this.styleLabel,
    this.iconColor,
  }) : assert(!obscureText || suffixIcon == null,
            'suffixIcon is only used when obscureText is false');

  @override
  State<TextFieldWithLabel> createState() => _TextFieldWithLabelState();
}

class _TextFieldWithLabelState extends State<TextFieldWithLabel> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Column(
            children: [
              Text(widget.label!,
                  style: widget.styleLabel ??
                      TextStyle(
                        color: widget.colorLabel?.withOpacity(0.7) ?? Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Montserrat',
                      )),
              const SizedBox(height: 8),
            ],
          ),
        TextFormField(
          autovalidateMode: widget.autovalidateMode,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          inputFormatters: widget.inputFormatters,
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          validator: widget.validator,
          textAlign: widget.textAlign,
          controller: widget.controller,
          obscureText: widget.obscureText ? !_passwordVisible : false,
          enabled: widget.enabled ?? true,
          autofocus: widget.autofocus ?? false,
          onChanged: widget.onChanged,
          style: TextStyle(
            color: widget.colorLabel ?? Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'Montserrat',
          ),
          decoration: InputDecoration(
            suffixText: widget.suffixText,
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: widget.iconColor,
                    ),
                  )
                : widget.suffixIcon,
            hintText: widget.hint,
            hintStyle: TextStyle(
              fontSize: 14,
              color: widget.colorLabel?.withOpacity(0.5) ?? Theme.of(context).colorScheme.outline,
              fontWeight: FontWeight.w400,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: widget.colorLabel ?? Colors.white,
                width: 1,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: widget.colorLabel ?? Colors.white,
                width: 1,
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 1,
              ),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 1,
              ),
            ),
            errorStyle: widget.hideErrorText
                ? const TextStyle(height: 0)
                : TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
            errorText: widget.hasError ? ' ' : widget.errorText,
            contentPadding: const EdgeInsets.only(bottom: 8),
          ),
        ),
      ],
    );
  }
}
