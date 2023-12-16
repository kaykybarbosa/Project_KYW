import 'package:flutter/material.dart';

class MyCreationInput extends StatelessWidget {
  const MyCreationInput({
    super.key,
    required this.text,
    this.placeHolder,
    this.maxLine,
    this.textInputType,
    this.showText = true,
    this.onChange,
    this.errorMessage,
  });

  final Function? onChange;
  final String text;
  final String? placeHolder;
  final int? maxLine;
  final TextInputType? textInputType;
  final bool showText;
  final String? errorMessage;

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
                child: _MyTitle(text: text),
              ),

              const SizedBox(height: 5.0),

              // Input
              Container(
                padding: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  maxLines: maxLine,
                  keyboardType: textInputType,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 10,
                    ),
                    prefixIconConstraints: BoxConstraints(minWidth: 48),
                    prefixIcon: Expanded(child: ColoredBox(color: Colors.red)),
                    hintText: placeHolder,
                    alignLabelWithHint: true,
                    errorText: errorMessage,
                  ),
                  onChanged: (value) => onChange!(value),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MyTitle extends StatelessWidget {
  const _MyTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

class _MyPrefix extends StatelessWidget {
  const _MyPrefix({required this.heightPrefix});

  final double? heightPrefix;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightPrefix,
      width: 9.0,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(3.9),
          bottomLeft: Radius.circular(3.9),
        ),
      ),
    );
  }
}
