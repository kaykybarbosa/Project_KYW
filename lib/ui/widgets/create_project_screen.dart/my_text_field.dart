import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    this.text,
    this.initialValue,
    this.onChange,
    this.placeHolder,
    this.maxLine,
    this.textInputType,
    this.showText = true,
    this.errorMessage,
    this.suffix,
    this.enable,
    this.controller,
    this.textInputAction,
  });

  final Function(String)? onChange;
  final String? text;
  final String? initialValue;
  final String? placeHolder;
  final int? maxLine;
  final TextInputType? textInputType;
  final bool showText;
  final String? errorMessage;
  final Widget? suffix;
  final bool? enable;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    var border = const BorderSide(color: TColors.base150);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /// Título
        Visibility(
          visible: showText,
          child: _MyTitle(text: text),
        ),

        // Input
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Container(
            padding: const EdgeInsets.only(left: 5),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border(top: border, right: border, bottom: border),
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: TColors.base200,
                  blurRadius: TConstants.blurRadius,
                )
              ],
            ),
            child: TextFormField(
              initialValue: initialValue,
              controller: controller,
              enabled: enable,
              maxLines: maxLine,
              keyboardType: textInputType,
              textInputAction: textInputAction,
              style: TextStyle(color: Theme.of(context).primaryColor),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                hintText: placeHolder,
                alignLabelWithHint: true,
                suffixIcon: suffix,
              ),
              onChanged: onChange,
            ),
          ),
          subtitle: _ErrorMessage(errorMessage: errorMessage),
        ),
      ],
    );
  }
}

class _MyTitle extends StatelessWidget {
  const _MyTitle({required this.text});

  final String? text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 2, bottom: 4),
        child: Text(
          text!,
          style: TextStyle(
            fontSize: TConstants.fontSizeLg,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({required this.errorMessage});

  final String? errorMessage;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 14, top: 5, bottom: 2),
        child: Visibility(
          visible: errorMessage != null,
          child: Text(
            errorMessage ?? '',
            style: const TextStyle(
              fontSize: TConstants.fontSizeSm,
              color: TColors.warn,
            ),
          ),
        ),
      );
}
