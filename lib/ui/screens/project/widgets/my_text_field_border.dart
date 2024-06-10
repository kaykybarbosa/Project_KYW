import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kyw_management/ui/widgets/text_field/title_text_field.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

class MyTextFieldBorder extends StatelessWidget {
  const MyTextFieldBorder({
    super.key,
    this.text,
    this.initialValue,
    this.onChanged,
    this.placeHolder,
    this.maxLine,
    this.textInputType,
    this.showText = true,
    this.errorText,
    this.suffix,
    this.enable,
    this.controller,
    this.textInputAction,
    this.inputFormatter,
  });

  final Function(String)? onChanged;
  final String? text;
  final String? initialValue;
  final String? placeHolder;
  final int? maxLine;
  final TextInputType? textInputType;
  final bool showText;
  final String? errorText;
  final Widget? suffix;
  final bool? enable;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputFormatter? inputFormatter;

  @override
  Widget build(BuildContext context) {
    const border = BorderSide(color: TColors.base150);
    const radiusRight = Radius.circular(TConstants.cardRadiusXs);
    const radiusLeftInput = Radius.circular(TConstants.radiusLeftInput);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /// Título
        Visibility(
          visible: showText,
          child: TitleTextField(text),
        ),

        /// Input
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TConstants.cardRadiusXs),
              border: Border(
                left: BorderSide(
                  color: theme.primaryColor,
                  width: 6,
                ),
              ),
              boxShadow: const [
                BoxShadow(
                  color: TColors.base200,
                  blurRadius: TConstants.blurRadius,
                )
              ],
            ),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: radiusLeftInput,
                  bottomLeft: radiusLeftInput,
                  topRight: radiusRight,
                  bottomRight: radiusRight,
                ),
                border: Border(
                  top: border,
                  right: border,
                  bottom: border,
                ),
              ),
              child: TextFormField(
                initialValue: initialValue,
                controller: controller,
                enabled: enable,
                maxLines: maxLine,
                keyboardType: textInputType,
                textInputAction: textInputAction,
                style: TextStyle(color: theme.primaryColor),
                inputFormatters: inputFormatter != null ? [inputFormatter!] : [],
                onChanged: onChanged,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.primaryColor),
                    borderRadius: const BorderRadius.only(
                      topLeft: radiusLeftInput,
                      bottomLeft: radiusLeftInput,
                      topRight: radiusRight,
                      bottomRight: radiusRight,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.only(
                      topLeft: radiusLeftInput,
                      bottomLeft: radiusLeftInput,
                      topRight: radiusRight,
                      bottomRight: radiusRight,
                    ),
                  ),
                  hintText: placeHolder,
                  alignLabelWithHint: true,
                  suffixIcon: suffix,
                  hintStyle: errorText != null ? TextStyle(color: theme.colorScheme.error.withOpacity(.8)) : null,
                ),
              ),
            ),
          ),
          subtitle: _ErrorMessage(errorMessage: errorText),
        ),
      ],
    );
  }
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
