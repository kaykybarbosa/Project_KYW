import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/app/decorations/my_decorations.dart';
import 'package:kyw_management/app/my_app.dart';
import 'package:kyw_management/app/validation/date_validator.dart';

class CreationDate extends StatefulWidget {
  const CreationDate({
    super.key,
    required this.isInitDate,
    required this.controller,
    required this.showCalendar,
    this.onTap,
  });

  final bool isInitDate;
  final TextEditingController controller;
  final Function showCalendar;
  final Function? onTap;

  @override
  State<CreationDate> createState() => _CreationDateState();
}

class _CreationDateState extends State<CreationDate> {
  BoxDecoration _decoration = MyDecorations.inputDecoration();

  void _setDecorationInvalid({bool isInvalid = false}) {
    setState(() {
      _decoration = MyDecorations.inputDecoration(
        borderColor:
            isInvalid ? CupertinoColors.systemRed : CupertinoColors.systemGrey,
      );
    });
  }

  void _validator({required String value}) {
    bool isValid;

    try {
      isValid =
          DateValidator.validateDate(formatter.parseUTC(value).toString());
    } catch (e) {
      isValid = false;
    }

    if (!isValid) {
      _setDecorationInvalid(isInvalid: true);
    } else {
      _setDecorationInvalid(isInvalid: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          widget.isInitDate ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        _dateText(text: widget.isInitDate ? 'Início' : 'Fim'),
        SizedBox(
          width: 150.0,
          child: CupertinoTextField(
            placeholder: 'dd/mm/yyyy',
            placeholderStyle: const TextStyle(
              fontSize: 16.0,
              color: CupertinoColors.placeholderText,
            ),
            style: const TextStyle(fontSize: 16.0),
            controller: widget.controller,
            decoration: _decoration,
            suffix: IconButton(
              icon: const Icon(Icons.calendar_today_rounded),
              onPressed: () {
                widget.showCalendar();
              },
            ),
            onTap: () => widget.onTap,
            onChanged: (value) {
              _validator(value: value);
            },
          ),
        ),
      ],
    );
  }

  Text _dateText({required String text}) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18.0,
        color: CupertinoColors.systemGrey,
      ),
    );
  }
}
