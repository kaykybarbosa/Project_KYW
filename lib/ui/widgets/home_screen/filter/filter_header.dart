import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kyw_management/domain/enums/filters_enum.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/filter_buttons.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/my_selection_date.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/texts.dart';

class FilterHeader extends StatelessWidget {
  const FilterHeader({
    super.key,
    this.labelInitDate,
    this.labelFinalDate,
    this.currentFilter = FilterEnum.Filter,
    required this.onInitDatePicker,
    required this.onFinalDatePicker,
    required this.onClean,
  });

  final String? labelInitDate;
  final String? labelFinalDate;
  final FilterEnum currentFilter;
  final Function(DateTime?) onInitDatePicker;
  final Function(DateTime?) onFinalDatePicker;
  final Function() onClean;

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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        /// Botôes de actions
        FilterButtons(
          current: currentFilter,
          clearFunction: onClean,
        ),

        const Gap(20.0),

        /// Título data de criação
        const _CreationDate(),

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
}

class _CreationDate extends StatelessWidget {
  const _CreationDate();

  @override
  Widget build(BuildContext context) => const Text(
        TTexts.criationDate,
        style: TextStyle(
          fontSize: TConstants.fontSizeLg + 2,
          fontWeight: FontWeight.w500,
        ),
      );
}
