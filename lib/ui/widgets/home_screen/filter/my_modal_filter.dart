import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:kyw_management/domain/enums/filters_enum.dart';
import 'package:kyw_management/domain/enums/screens.dart';
import 'package:kyw_management/ui/state_management/blocs/filter_project_bloc/filter_project_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/filter_task_bloc/filter_task_bloc.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/apply_button.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/filter_buttons.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/filter_projet/filter_for_project.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/filter_task/filter_for_task.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/my_selection_date.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/texts.dart';

DateFormat formatter = DateFormat("dd/MM/yyyy");

class MyModalFilter extends StatelessWidget {
  const MyModalFilter({super.key, required this.currentScreen});

  final Screens currentScreen;

  @override
  Widget build(BuildContext context) {
    void setDate({
      required bool isInitDate,
      DateTime? dateSelected,
    }) {
      if (dateSelected != null) {
        var date = formatter.format(dateSelected);
        if (isInitDate) {
          context.read<FilterProjectBloc>().add(InitDateChanged(initDate: date));
        } else {
          context.read<FilterProjectBloc>().add(FinalDateChanged(finalDate: date));
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 33),
      child: BlocBuilder<FilterProjectBloc, FilterProjectState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// Botôes de actions
                  FilterButtons(
                    current: FilterEnum.Filter,
                    clearFunction: () => _clearFilter(context),
                  ),

                  const Gap(20.0),

                  /// Data de criação
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
                            hintText: state.initDate.isNotEmpty ? state.initDate : null,
                            showCalendar: () async {
                              DateTime? dateSelected = await _showCalendar(context);

                              setDate(
                                isInitDate: state.isInitDate,
                                dateSelected: dateSelected,
                              );
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
                            hintText: state.finalDate.isNotEmpty ? state.finalDate : null,
                            showCalendar: () async {
                              DateTime? dateSelected = await _showCalendar(context);

                              setDate(
                                isInitDate: !state.isInitDate,
                                dateSelected: dateSelected,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const Gap(20),

                  /// If [currentScreen] is Project, show the filters to Project
                  Visibility(
                    visible: currentScreen == Screens.project,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: FilterForProject(),
                    ),
                  ),

                  /// Else if [currentScreen] is Tasks, show filters to Tasks
                  Visibility(
                    visible: currentScreen == Screens.task,
                    child: const FilterForTask(),
                  ),
                ],
              ),
              const Gap(30),

              // Apply filter
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ApplyButtom(onPressed: () {}),
              )
            ],
          );
        },
      ),
    );
  }

  void _clearFilter(BuildContext context) {
    if (currentScreen == Screens.project) {
      context.read<FilterProjectBloc>().add(ResetFilterProject());
    } else {
      context.read<FilterProjectBloc>().add(ResetFilterProject());
      context.read<FilterTaskBloc>().add(ResetFilterTask());
    }
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
