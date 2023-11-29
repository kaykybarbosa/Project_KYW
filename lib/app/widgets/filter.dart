import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kyw_management/app/decorations/my_decorations.dart';
import 'package:kyw_management/app/enums/filters_enum.dart';
import 'package:kyw_management/app/enums/screens.dart';
import 'package:kyw_management/app/enums/status.dart';
import 'package:kyw_management/app/validation/date_validator.dart';
import 'package:kyw_management/app/widgets/filter_buttons.dart';
import 'package:kyw_management/app/widgets/my_status.dart';

final formatter = DateFormat("dd/MM/yyyy");

class Filter extends StatefulWidget {
  const Filter({
    super.key,
    required this.currentScreen,
  });

  final Screens currentScreen;

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  // Variables

  // DateTime? _initDateSelected;
  // DateTime? _finalDateSelected;
  // DateTime? _dateSelected;

  // 1.1 Projects
  bool _isCreatedByMe = false;
  bool _isMarked = false;
  // 1.2 Taks
  bool _complete = false;
  bool _pending = false;
  bool _incomplete = false;

  BoxDecoration _decoration = MyDecorations.inputDecoration();
  final _initDateController = TextEditingController();
  final _finalDateController = TextEditingController();

  // Widgets
  Text _dateText({required String text}) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18.0,
        color: CupertinoColors.systemGrey,
      ),
    );
  }

  CupertinoTextField _dateInput({
    required TextEditingController controller,
    required bool isInitDate,
  }) {
    return CupertinoTextField(
      placeholder: 'dd/mm/yyyy',
      placeholderStyle: const TextStyle(
        fontSize: 16.0,
        color: CupertinoColors.placeholderText,
      ),
      style: const TextStyle(fontSize: 16.0),
      controller: controller,
      decoration: _decoration,
      suffix: IconButton(
        icon: const Icon(CupertinoIcons.calendar),
        onPressed: () async {
          // Calendar
          DateTime? dateSelected = await _showCalendar();

          if (isInitDate && dateSelected != null) {
            _initDateController.text = formatter.format(dateSelected);
          } else if (dateSelected != null) {
            _finalDateController.text = formatter.format(dateSelected);
          }
        },
      ),
      onChanged: (value) {
        bool isValid =
            DateValidator.validateDate(formatter.parseUTC(value).toString());
        if (!isValid) {
          _setDecorationInvalid(isInvalid: true);
        } else {
          _setDecorationInvalid(isInvalid: false);
        }
      },
    );
  }

  Container _filterWithChecked({
    required String text,
    required bool isCreatedByMe,
  }) {
    bool isChecked = false;

    if (isCreatedByMe) {
      setState(() {
        isChecked = _isCreatedByMe;
      });
    } else {
      isChecked = _isMarked;
    }

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
            text,
            style: const TextStyle(
              fontSize: 20.0,
              color: CupertinoColors.activeBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
          Transform.scale(
            scale: 1.1,
            child: Checkbox(
              value: isChecked,
              checkColor: CupertinoColors.white,
              overlayColor: MaterialStateProperty.all(Colors.grey[200]),
              activeColor: CupertinoColors.systemGrey,
              onChanged: (bool? value) {
                setState(() {
                  if (isCreatedByMe && value != null) {
                    _isCreatedByMe = value;
                  } else if (value != null) {
                    _isMarked = value;
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Transform _myCheckBox({required Status status}) {
    bool isChecked;
    if (status == Status.completo) {
      isChecked = _complete;
    } else if (status == Status.incompleto) {
      isChecked = _incomplete;
    } else {
      isChecked = _pending;
    }

    return Transform.scale(
      scale: 1,
      child: Checkbox(
        value: isChecked,
        checkColor: CupertinoColors.white,
        overlayColor: MaterialStateProperty.all(Colors.grey[200]),
        activeColor: CupertinoColors.systemGrey,
        onChanged: (bool? value) {
          setState(() {
            if (status == Status.completo && value != null) {
              _complete = value;
            } else if (status == Status.incompleto && value != null) {
              _incomplete = value;
            } else if (value != null) {
              _pending = value;
            }
          });
        },
      ),
    );
  }

  // Functions
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
          ),
          child: widget!,
        );
      },
    );

    return dateSelected;
  }

  void _setDecorationInvalid({bool isInvalid = false}) {
    setState(() {
      _decoration = MyDecorations.inputDecoration(
        borderColor:
            isInvalid ? CupertinoColors.systemRed : CupertinoColors.systemGrey,
      );
    });
  }

  @override
  void dispose() {
    _initDateController.dispose();
    _finalDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(
        horizontal: 25.0,
        vertical: 20.0,
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // The 3 buttons
            FilterButtons(current: FilterEnum.Filter, reset: () {}),

            const SizedBox(height: 30.0),

            // Creation date
            const Text(
              'Data de criação',
              style: TextStyle(fontSize: 20.0),
            ),

            const SizedBox(height: 15.0),

            //Star date and Final date
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text
                    _dateText(text: 'Início'),
                    _dateText(text: 'Fim'),
                  ],
                ),
                Row(
                  children: [
                    // Init Date
                    SizedBox(
                      width: 150.0,
                      child: _dateInput(
                        controller: _initDateController,
                        isInitDate: true,
                      ),
                    ),

                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(color: CupertinoColors.systemGrey),
                      ),
                    ),

                    // Final Date
                    SizedBox(
                      width: 150.0,
                      child: _dateInput(
                        controller: _finalDateController,
                        isInitDate: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 40.0),

            /// If [currentScreen] is Project, show the filters to Project
            Visibility(
              visible: widget.currentScreen == Screens.project,
              child: Expanded(
                child: Column(
                  children: [
                    // Created by me
                    _filterWithChecked(
                      text: 'Criado por me',
                      isCreatedByMe: true,
                    ),

                    const SizedBox(height: 25.0),

                    // Onle marked
                    _filterWithChecked(
                      text: 'Marcados',
                      isCreatedByMe: false,
                    ),

                    const Spacer(),
                  ],
                ),
              ),
            ),

            /// Else if [currentScreen] is Tasks, show filters to Tasks
            Visibility(
              visible: widget.currentScreen == Screens.task,
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // The three Status CheckBox
                    const Text(
                      'Status',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Row(
                      children: [
                        _myCheckBox(status: Status.pendente),
                        MyStatus(status: Status.pendente)
                      ],
                    ),
                    Row(
                      children: [
                        _myCheckBox(status: Status.completo),
                        MyStatus(status: Status.completo)
                      ],
                    ),
                    Row(
                      children: [
                        _myCheckBox(status: Status.incompleto),
                        MyStatus(status: Status.incompleto)
                      ],
                    ),

                    const SizedBox(height: 20.0),

                    // Category
                    const Text(
                      'Category',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              ),
            ),

            // Apply filter or Order
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                color: CupertinoColors.systemBlue,
                child: const Text(
                  'Aplicar',
                  style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
