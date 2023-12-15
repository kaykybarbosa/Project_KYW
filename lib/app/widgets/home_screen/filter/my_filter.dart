import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/app/enums/filters_enum.dart';
import 'package:kyw_management/app/enums/screens.dart';
import 'package:kyw_management/app/my_app.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/apply_button.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/filter_buttons.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/my_selection_date.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/filter_projet/filter_with_check.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/filter_task/filter_for_task.dart';

import '../../../../domain/blocs/blocs_export.dart';

class MyFilter extends StatefulWidget {
  const MyFilter({super.key, required this.currentScreen});

  final Screens currentScreen;

  @override
  State<MyFilter> createState() => _MyFilterState();
}

class _MyFilterState extends State<MyFilter> {
  // Functions
  void _setDate({
    required bool isInitDate,
    DateTime? dateSelected,
  }) {
    if (dateSelected != null) {
      var date = formatter.format(dateSelected);
      if (isInitDate) {
        context.read<FilterProjectBloc>().add(InitDateChanged(initDate: date));
      } else {
        context
            .read<FilterProjectBloc>()
            .add(FinalDateChanged(finalDate: date));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 33.0),
      child: BlocBuilder<FilterProjectBloc, FilterProjectState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // The 3 buttons
                  FilterButtons(
                    current: FilterEnum.Filter,
                    resetFunction: () => context
                        .read<FilterProjectBloc>()
                        .add(ResetFilterProject()),
                  ),

                  const SizedBox(height: 30.0),

                  // Label creation date
                  const _CreationDate(),

                  const SizedBox(height: 15.0),

                  // Star date and Final date
                  SizedBox(
                    height: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Init Date
                        MySelectionDate(
                          title: 'Início',
                          hintText: state.initDate.isEmpty
                              ? 'dd/MM/yyyy'
                              : state.initDate,
                          showCalendar: () async {
                            DateTime? dateSelected =
                                await _showCalendar(context);

                            _setDate(
                              isInitDate: state.isInitDate,
                              dateSelected: dateSelected,
                            );
                          },
                        ),

                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Divider(color: CupertinoColors.systemGrey),
                          ),
                        ),

                        // Final Date
                        MySelectionDate(
                          title: 'Fim',
                          hintText: state.finalDate.isEmpty
                              ? 'dd/MM/yyyy'
                              : state.finalDate,
                          showCalendar: () async {
                            DateTime? dateSelected =
                                await _showCalendar(context);

                            _setDate(
                              isInitDate: !state.isInitDate,
                              dateSelected: dateSelected,
                            );
                          },
                        )
                      ],
                    ),
                  ),

                  /// If [currentScreen] is Project, show the filters to Project
                  Visibility(
                    visible: widget.currentScreen == Screens.project,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: _FilterForProject(),
                    ),
                  ),

                  /// Else if [currentScreen] is Tasks, show filters to Tasks
                  Visibility(
                    visible: widget.currentScreen == Screens.task,
                    child: const FilterForTask(),
                  ),
                ],
              ),

              // Apply filter
              ApplyButtom(onTap: () {})
            ],
          );
        },
      ),
    );
  }
}

class _CreationDate extends StatelessWidget {
  const _CreationDate();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Data de criação',
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

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

class _FilterForProject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterProjectBloc, FilterProjectState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Created by me
            FilterWithCheck(
              label: 'Criado por me',
              isChecked: state.createdByMe,
              onChanged: (value) =>
                  context.read<FilterProjectBloc>().add(CreatedByMeChanged()),
            ),

            const SizedBox(height: 25.0),

            // Onle marked
            FilterWithCheck(
              label: 'Marcados',
              isChecked: state.marked,
              onChanged: (value) =>
                  context.read<FilterProjectBloc>().add(MarkedChanged()),
            ),
          ],
        );
      },
    );
  }
}
