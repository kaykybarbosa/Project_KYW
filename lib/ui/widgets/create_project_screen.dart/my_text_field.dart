import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.text,
    required this.onChange,
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

  final Function onChange;
  final String text;
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text
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
            decoration: _boxDecoration(context),
            child: TextField(
              controller: controller,
              enabled: enable,
              maxLines: maxLine,
              keyboardType: textInputType,
              textInputAction: textInputAction,
              style: TextStyle(color: Theme.of(context).primaryColor),
              decoration: _inputDecoration(context),
              onChanged: (value) => onChange(value),
            ),
          ),
          subtitle: _SubTitle(errorMessage: errorMessage),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(BuildContext context) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
      hintText: placeHolder,
      alignLabelWithHint: true,
      suffixIcon: suffix,
    );
  }

  BoxDecoration _boxDecoration(BuildContext context) {
    var border = const BorderSide(color: Colors.grey);

    return BoxDecoration(
      color: Theme.of(context).primaryColor,
      border: Border(top: border, right: border, bottom: border),
      borderRadius: BorderRadius.circular(5),
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          spreadRadius: .3,
          blurRadius: 5.5,
        ),
      ],
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({required this.errorMessage});

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, top: 5, bottom: 2),
      child: Visibility(
        visible: errorMessage != null,
        child: Text(
          errorMessage ?? '',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}

class _MyTitle extends StatelessWidget {
  const _MyTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, bottom: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
