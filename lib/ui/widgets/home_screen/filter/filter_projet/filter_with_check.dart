import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

class FilterWithCheck extends StatefulWidget {
  const FilterWithCheck({
    super.key,
    required this.label,
    required this.onChanged,
    this.isChecked = false,
  });

  final bool isChecked;
  final String label;
  final Function(bool?)? onChanged;

  @override
  State<FilterWithCheck> createState() => _FilterWithCheckState();
}

class _FilterWithCheckState extends State<FilterWithCheck> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(TConstants.cardRadiusXs),
        color: TColors.base100,
        border: Border.all(color: TColors.primary),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          /// Nome
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: TConstants.fontSizeLg,
              color: TColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),

          /// Checkbox
          Checkbox(
            value: widget.isChecked,
            onChanged: widget.onChanged,
          )
        ],
      ),
    );
  }
}
