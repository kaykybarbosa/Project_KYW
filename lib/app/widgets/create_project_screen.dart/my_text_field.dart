import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: _MyTitle(text: text),
                ),
              ),

              const SizedBox(height: 5.0),

              // Input
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Container(
                  padding: const EdgeInsets.only(
                      left: 5, top: 0, right: 0, bottom: 0),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: _boxDecoration(context),
                  child: TextField(
                    maxLines: maxLine,
                    keyboardType: textInputType,
                    decoration: _inputDecoration(context),
                    onChanged: (value) => onChange!(value),
                  ),
                ),
                subtitle: _SubTitle(errorMessage: errorMessage),
              ),
            ],
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(BuildContext context) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent)),
      hintText: placeHolder,
      alignLabelWithHint: true,
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
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 5,
      ),
      child: Text(
        errorMessage ?? '',
        style: const TextStyle(
          fontSize: 12,
          color: Colors.redAccent,
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
