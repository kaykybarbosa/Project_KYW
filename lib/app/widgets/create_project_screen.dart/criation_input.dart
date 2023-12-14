import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCreationInput extends StatelessWidget {
  const MyCreationInput({
    super.key,
    required this.text,
    required this.placeHolder,
    this.heightPrefix = 36.0,
    this.maxLine,
    this.maxLength,
    this.textInputType,
    this.showText = true,
    this.onChange,
  });

  final Function? onChange;
  final String text;
  final String placeHolder;
  final double? heightPrefix;
  final int? maxLine;
  final int? maxLength;
  final TextInputType? textInputType;
  final bool showText;

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
              CupertinoTextFormFieldRow(
                maxLines: maxLine,
                maxLength: maxLength,
                keyboardType: textInputType,
                placeholder: placeHolder,
                padding: EdgeInsets.zero,
                decoration: _myDecoration(),
                prefix: _MyPrefix(heightPrefix: heightPrefix),
                onChanged: (value) => onChange!(value),
              ),
            ],
          ),
        ),
      ],
    );
  }

  BoxDecoration _myDecoration() {
    return BoxDecoration(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(5.0),
        bottomRight: Radius.circular(5.0),
      ),
      border: Border.all(color: Colors.grey),
      color: const Color.fromARGB(153, 242, 242, 247),
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
