import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

class MySelectionDate extends StatelessWidget {
  const MySelectionDate({
    super.key,
    required this.title,
    required this.onTap,
    this.hintText,
  });

  final String title;
  final Function() onTap;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /// Título
        _dateText(title),
        const Gap(5),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: TColors.base100,
              borderRadius: BorderRadius.circular(TConstants.cardRadiusXs),
              border: Border.all(color: TColors.base200),
              boxShadow: const [
                BoxShadow(
                  color: TColors.base200,
                  blurRadius: 6,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /// Label do input
                Text(
                  hintText ?? 'dd/MM/yyyy',
                  style: TextStyle(
                    fontSize: TConstants.fontSizeMd,
                    color: hintText != null ? TColors.secondary : TColors.base150,
                  ),
                ),

                /// Ícone
                const Icon(
                  Icons.calendar_today_rounded,
                  color: TColors.base150,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Text _dateText(text) => Text(
      text,
      style: const TextStyle(
        fontSize: TConstants.fontSizeLg,
        color: TColors.base200,
      ),
    );
