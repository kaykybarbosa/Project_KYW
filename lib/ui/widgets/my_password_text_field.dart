import 'package:flutter/material.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/helper_functions.dart';
import 'package:kyw_management/utils/icons.dart';

class MyPasswordTextField extends StatelessWidget {
  const MyPasswordTextField({
    super.key,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.initialValue,
    this.suffixOnTap,
    this.onChanged,
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
    this.isUnderlineInput = false,
  });

  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final String? initialValue;
  final bool isUnderlineInput;
  final Function()? suffixOnTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) => TextFormField(
        initialValue: initialValue,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: !isUnderlineInput,
          hintText: hintText,
          errorText: errorText,
          border: isUnderlineInput ? UnderlineInputBorder(borderSide: HelperFunctions.border(context)) : null,
          focusedBorder:
              isUnderlineInput ? UnderlineInputBorder(borderSide: HelperFunctions.focusedBorder(context)) : null,
          enabledBorder:
              isUnderlineInput ? UnderlineInputBorder(borderSide: HelperFunctions.enabledBorder(context)) : null,
          disabledBorder:
              isUnderlineInput ? UnderlineInputBorder(borderSide: HelperFunctions.enabledBorder(context)) : null,
          errorBorder: isUnderlineInput ? UnderlineInputBorder(borderSide: HelperFunctions.errorBorder(context)) : null,
          focusedErrorBorder:
              isUnderlineInput ? UnderlineInputBorder(borderSide: HelperFunctions.focusedErrorBorder(context)) : null,
          suffix: InkWell(
            onTap: suffixOnTap,
            child: _SuffixIcon(obscureText: obscureText),
          ),
          hintStyle: TextStyle(
            color: errorText != null ? Theme.of(context).colorScheme.error : HelperFunctions.hintStyle(context).color,
          ),
        ),
        textInputAction: textInputAction,
        onFieldSubmitted: onSubmitted,
        onChanged: onChanged,
      );
}

class _SuffixIcon extends StatelessWidget {
  const _SuffixIcon({required this.obscureText});

  final bool obscureText;

  @override
  Widget build(BuildContext context) => Icon(
        obscureText ? TIcons.eyesOff : TIcons.eyes,
        size: TConstants.iconSm,
        color: Theme.of(context).colorScheme.onBackground,
      );
}
