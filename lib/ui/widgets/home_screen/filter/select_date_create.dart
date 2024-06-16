import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/my_selection_date.dart';
import 'package:kyw_management/ui/widgets/section_title.dart';
import 'package:kyw_management/utils/texts.dart';

class SelectDateCreate extends StatelessWidget {
  const SelectDateCreate({
    super.key,
    this.labelInitDate,
    this.labelFinalDate,
    required this.onInitDatePicker,
    required this.onFinalDatePicker,
  });

  final String? labelInitDate;
  final String? labelFinalDate;
  final Function(DateTime?) onInitDatePicker;
  final Function(DateTime?) onFinalDatePicker;

  /// Dialog para escolher a data
  Future<DateTime?> _showCalendar(BuildContext context) async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 2, now.month, now.day);

    final dateSelected = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
      barrierColor: const Color.fromARGB(45, 255, 255, 255),
    );

    return dateSelected;
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          /// Título data de criação
          const SectionTitle(title: TTexts.criationDate),

          const Gap(10.0),

          /// Inputs para as data de início e fim
          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                /// -- Data inicial
                Expanded(
                  flex: 6,
                  child: MySelectionDate(
                    title: TTexts.start,
                    hintText: labelInitDate,
                    onTap: () async {
                      DateTime? dateSelected = await _showCalendar(context);
                      onInitDatePicker(dateSelected);
                    },
                  ),
                ),

                /// -- Divisior
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, top: 35, right: 8),
                    child: Divider(),
                  ),
                ),

                /// -- Data final
                Expanded(
                  flex: 6,
                  child: MySelectionDate(
                    title: TTexts.end,
                    hintText: labelFinalDate,
                    onTap: () async {
                      DateTime? dateSelected = await _showCalendar(context);
                      onFinalDatePicker(dateSelected);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      );
}
