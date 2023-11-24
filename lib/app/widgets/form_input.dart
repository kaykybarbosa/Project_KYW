import 'package:flutter/cupertino.dart';
import 'package:kyw_management/app/decorations/my_decorations.dart';

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
    this.inputDecoration,
    this.obscureText,
  });

  final String placeHolder;
  final TextEditingController inputController;
  final Function validator;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  AutovalidateMode autovalidateMode;
  EdgeInsetsGeometry? padding;
  TextAlign textAlign;
  TextStyle? placeHolderStyle;
  TextStyle? inputTextStyle;
  BoxDecoration? inputDecoration;
  bool? obscureText;

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
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
      placeholderStyle:
          widget.placeHolderStyle ?? MyDecorations.placeHolderStyle(),
      decoration: widget.inputDecoration ?? MyDecorations.inputDecoration(),
      style: widget.inputTextStyle ?? MyDecorations.inputTextStyle(),
      onTap: () {
        setState(() {
          widget.inputDecoration =
              MyDecorations.inputDecoration(isActice: true);
        });
      },
      onChanged: (value) {
        setState(() {
          if (widget.validator(value) != null) {
            widget.inputDecoration = MyDecorations.inputDecoration(
                borderColor: CupertinoColors.systemRed, isActice: true);
          } else {
            widget.inputDecoration =
                MyDecorations.inputDecoration(isActice: true);
          }
        });
      },
      onEditingComplete: () {
        setState(() {
          widget.inputDecoration =
              MyDecorations.inputDecoration(isActice: false);
        });
      },
      validator: (value) {
        return widget.validator(value);
      },
    );
  }
}
