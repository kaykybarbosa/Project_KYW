import 'package:flutter/cupertino.dart';
import 'package:kyw_management/ui/decorations/my_decorations.dart';

// ignore: must_be_immutable
class FormInput extends StatefulWidget {
  FormInput({
    super.key,
    required this.placeHolder,
    required this.inputController,
    required this.validator,
    this.textInputType,
    this.textInputAction,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.padding,
    this.textAlign = TextAlign.start,
    this.placeHolderStyle,
    this.inputTextStyle,
    this.obscureText,
    this.inputDecoration,
  });

  final String placeHolder;
  final TextEditingController inputController;
  final Function validator;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final AutovalidateMode autovalidateMode;
  final EdgeInsetsGeometry? padding;
  final TextAlign textAlign;
  final TextStyle? placeHolderStyle;
  final TextStyle? inputTextStyle;
  final bool? obscureText;
  BoxDecoration? inputDecoration;

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  void _setInputDecoration({Color? borderColor, bool isActice = false}) {
    setState(() {
      widget.inputDecoration = MyDecorations.inputDecoration(borderColor: borderColor, isActice: isActice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextFormFieldRow(
      placeholder: widget.placeHolder,
      controller: widget.inputController,
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      autovalidateMode: widget.autovalidateMode,
      obscureText: widget.obscureText ?? false,
      padding: widget.padding ?? EdgeInsets.zero,
      textAlign: widget.textAlign,
      placeholderStyle: widget.placeHolderStyle ?? MyDecorations.placeHolderStyle(),
      decoration: widget.inputDecoration ?? MyDecorations.inputDecoration(),
      style: widget.inputTextStyle ?? MyDecorations.inputTextStyle(),
      onTap: () {
        _setInputDecoration(isActice: true);
      },
      onChanged: (value) {
        if (widget.validator(value) != null) {
          _setInputDecoration(borderColor: CupertinoColors.systemRed, isActice: true);
        } else {
          _setInputDecoration(isActice: true);
        }
      },
      onEditingComplete: () {
        _setInputDecoration(isActice: false);
        if (widget.textInputAction != TextInputAction.next) {
          FocusScope.of(context).unfocus();
        }
      },
      validator: (value) {
        return widget.validator(value);
      },
    );
  }
}