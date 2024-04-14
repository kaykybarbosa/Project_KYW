import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

class FilterWithCheck extends StatelessWidget {
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
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: TColors.base100,
          border: Border.all(color: TColors.primary),
          borderRadius: BorderRadius.circular(TConstants.cardRadiusXs),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(.20),
              blurRadius: TConstants.blurRadius,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            /// Nome
            Text(
              label,
              style: const TextStyle(
                fontSize: TConstants.fontSizeLg,
                color: TColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),

            /// Checkbox
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: isChecked,
                onChanged: onChanged,
              ),
            )
          ],
        ),
      );
}
