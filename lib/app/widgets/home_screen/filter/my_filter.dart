import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/app/enums/filters_enum.dart';
import 'package:kyw_management/app/enums/screens.dart';
import 'package:kyw_management/app/my_app.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/apply_button.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/filter_buttons.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/creation_date.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/filter_projet/filter_with_check.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/filter_task/filter_for_task.dart';
import 'package:kyw_management/domain/cubits/filter_project_cubit/filter_project_cubit.dart';

class MyFilter extends StatefulWidget {
  const MyFilter({super.key, required this.currentScreen});

  final Screens currentScreen;

  @override
  State<MyFilter> createState() => _MyFilterState();
}

class _MyFilterState extends State<MyFilter> {
  // Variables

  // DateTime? _initDateSelected;
  // DateTime? _finalDateSelected;
  // DateTime? _dateSelected;

  final _initDateController = TextEditingController();
  final _finalDateController = TextEditingController();
  final _categoryController = TextEditingController();

  // Functions
  void _setDate({required bool isInitDate, DateTime? dateSelected}) {
    setState(() {
      if (dateSelected != null) {
        if (isInitDate) {
          _initDateController.text = formatter.format(dateSelected);
        } else {
          _finalDateController.text = formatter.format(dateSelected);
        }
      }
    });
  }

  @override
  void dispose() {
    _initDateController.dispose();
    _finalDateController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<DateTime?> _showCalendar() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 2, now.month, now.day);

    final dateSelected = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
      barrierColor: const Color.fromARGB(45, 255, 255, 255),
      builder: (BuildContext context, Widget? widget) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color.fromRGBO(50, 58, 71, 1),
            colorScheme: const ColorScheme.light(
              primary: CupertinoColors.systemBlue,
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
            datePickerTheme: const DatePickerThemeData(
                headerBackgroundColor: Color.fromARGB(240, 0, 123, 255)),
          ),
          child: widget!,
        );
      },
    );

    return dateSelected;
  }

  var clicked = false;

  void _setClicked(bool value) {
    setState(() {
      clicked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterProjectCubit(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 33.0),
        child: SingleChildScrollView(
          child: BlocBuilder<FilterProjectCubit, FilterProjectState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // The 3 buttons
                  FilterButtons(
                    current: FilterEnum.Filter,
                    resetFunction: () {},
                  ),

                  const SizedBox(height: 30.0),

                  // Creation date
                  const Text(
                    'Data de criação',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 15.0),

                  //Star date and Final date
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Init Date
                      CreationDate(
                        isInitDate: state.isInitDate,
                        controller: _initDateController,
                        showCalendar: () async {
                          DateTime? dateSelected = await _showCalendar();

                          _setDate(
                            isInitDate: state.isInitDate,
                            dateSelected: dateSelected,
                          );
                        },
                        onTap: () {
                          _setClicked(true);
                        },
                      ),

                      const Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 8.0, right: 8.0, top: 25.0),
                          child: Divider(color: CupertinoColors.systemGrey),
                        ),
                      ),

                      // Final Date
                      CreationDate(
                        isInitDate: false,
                        controller: _finalDateController,
                        showCalendar: () async {
                          DateTime? dateSelected = await _showCalendar();

                          _setDate(
                              isInitDate: false, dateSelected: dateSelected);
                        },
                        onTap: () {
                          _setClicked(true);
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 40.0),

                  /// If [currentScreen] is Project, show the filters to Project
                  Visibility(
                    visible: widget.currentScreen == Screens.project,
                    child: const _FilterForProject(),
                  ),

                  /// Else if [currentScreen] is Tasks, show filters to Tasks
                  Visibility(
                    visible: widget.currentScreen == Screens.task,
                    child: FilterForTask(
                      categoryController: _categoryController,
                      // onTap: () {
                      //   _setClicked(true);
                      // },
                    ),
                  ),

                  const SizedBox(height: 100.0),

                  // Apply filter
                  ApplyButtom(onTap: () {})
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FilterForProject extends StatefulWidget {
  const _FilterForProject();

  @override
  State<_FilterForProject> createState() => _FilterForProjectState();
}

class _FilterForProjectState extends State<_FilterForProject> {
  bool _isCreatedByMe = false;
  bool _isMarked = false;

  void _setCheckBox({bool? isChecked, bool isCreatedByMe = false}) {
    setState(() {
      if (isCreatedByMe && isChecked != null) {
        _isCreatedByMe = isChecked;
      } else if (isChecked != null) {
        _isMarked = isChecked;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Created by me
        FilterWithCheck(
          label: 'Criado por me',
          isChecked: _isCreatedByMe,
          onChanged: (value) {
            _setCheckBox(
              isChecked: value,
              isCreatedByMe: true,
            );
          },
        ),

        const SizedBox(height: 25.0),

        // Onle marked
        FilterWithCheck(
          label: 'Marcados',
          isChecked: _isMarked,
          onChanged: (value) {
            _setCheckBox(isChecked: value);
          },
        ),
      ],
    );
  }
}
