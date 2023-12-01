import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterWithCheck extends StatefulWidget {
  const FilterWithCheck({
    super.key,
    required this.label,
    required this.onChanged,
    this.isChecked = false,
  });

  final bool isChecked;
  final String label;
  final Function onChanged;

  @override
  State<FilterWithCheck> createState() => _FilterWithCheckState();
}

class _FilterWithCheckState extends State<FilterWithCheck> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(38, 0, 123, 255),
            spreadRadius: 3,
            blurRadius: 5.0,
          ),
        ],
        borderRadius: BorderRadius.circular(5.0),
        color: CupertinoColors.white,
        border: Border.all(
          color: CupertinoColors.systemBlue,
          width: 1.2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 20.0,
              color: CupertinoColors.activeBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
          Transform.scale(
            scale: 1.1,
            child: Checkbox(
              value: widget.isChecked,
              checkColor: CupertinoColors.white,
              overlayColor: MaterialStateProperty.all(Colors.grey[200]),
              activeColor: CupertinoColors.systemGrey,
              onChanged: (bool? value) {
                widget.onChanged(value);
              },
            ),
          )
        ],
      ),
    );
  }
}
