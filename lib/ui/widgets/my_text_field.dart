import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kyw_management/utils/constants.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    required this.hintText,
    this.errorText,
    this.helperText,
    this.initialValue,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.suffix,
    this.suffixIcon,
    this.suffixIconSize = TConstants.iconXs,
    this.controller,
    this.maxLines = 1,
    this.focusNode,
    this.canRequestFocus = true,
    this.enableInteractiveSelection,
    this.textCapitalization,
    this.isPasswordInput = false,
    this.isInputUnderline = false,
    this.contentPadding,
    this.onChanged,
    this.onSubmit,
    this.onTap,
  });

  final String hintText;
  final bool obscureText;
  final String? errorText;
  final String? helperText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final IconData? suffixIcon;
  final double suffixIconSize;
  final TextEditingController? controller;
  final int maxLines;
  final FocusNode? focusNode;
  final bool canRequestFocus;
  final bool? enableInteractiveSelection;
  final bool isInputUnderline;
  final EdgeInsetsGeometry? contentPadding;
  final TextCapitalization? textCapitalization;
  final Function(String value)? onChanged;
  final Function()? onSubmit;
  final Function()? onTap;

  final bool isPasswordInput;

  @override
  Widget build(BuildContext context) {
    final inputTheme = Theme.of(context).inputDecorationTheme;

    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      maxLines: maxLines,
      obscureText: obscureText,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      canRequestFocus: canRequestFocus,
      enableInteractiveSelection: enableInteractiveSelection,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        hintText: hintText,
        errorText: errorText,
        helperText: helperText,
        suffix: suffix,
        suffixIcon: suffixIcon != null
            ? Icon(
                suffixIcon,
                size: suffixIconSize,
              )
            : null,
        hintStyle: errorText != null ? TextStyle(color: Theme.of(context).colorScheme.error.withOpacity(.8)) : null,
        disabledBorder:
            isInputUnderline ? UnderlineInputBorder(borderSide: inputTheme.disabledBorder!.borderSide) : null,
        focusedBorder: isInputUnderline ? UnderlineInputBorder(borderSide: inputTheme.focusedBorder!.borderSide) : null,
        enabledBorder: isInputUnderline ? UnderlineInputBorder(borderSide: inputTheme.enabledBorder!.borderSide) : null,
        errorBorder: isInputUnderline ? UnderlineInputBorder(borderSide: inputTheme.errorBorder!.borderSide) : null,
        focusedErrorBorder:
            isInputUnderline ? UnderlineInputBorder(borderSide: inputTheme.focusedErrorBorder!.borderSide) : null,
      ),
      onTap: onTap,
      onEditingComplete: onSubmit,
      onChanged: onChanged,
    );
  }
}
