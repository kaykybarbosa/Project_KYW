import 'package:flutter/cupertino.dart';

class CreationInput extends StatelessWidget {
  const CreationInput({
    super.key,
    required this.onTap,
    required this.text,
    required this.placeHolder,
    required this.controller,
    required this.validation,
    this.heightPrefix = 36.0,
    this.maxLine,
    this.maxLength,
    this.textInputType,
    this.showText = true,
  });

  final Function onTap;
  final String text;
  final String placeHolder;
  final double? heightPrefix;
  final int? maxLine;
  final int? maxLength;
  final TextInputType? textInputType;
  final Function validation;
  final bool showText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text
              Visibility(
                visible: showText,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: CupertinoTheme.of(context).primaryColor,
                  ),
                ),
              ),

              const SizedBox(height: 5.0),

              // Input
              CupertinoTextFormFieldRow(
                maxLines: maxLine,
                maxLength: maxLength,
                keyboardType: textInputType,
                placeholder: placeHolder,
                padding: EdgeInsets.zero,
                controller: controller,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0),
                  ),
                  border: Border.all(color: CupertinoColors.systemGrey),
                  color: const Color.fromARGB(153, 242, 242, 247),
                ),
                prefix: Container(
                  height: heightPrefix,
                  width: 9.0,
                  decoration: BoxDecoration(
                    color: CupertinoTheme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(3.9),
                      bottomLeft: Radius.circular(3.9),
                    ),
                  ),
                ),
                onTap: () => onTap(),
                validator: (value) {
                  return validation(value);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
