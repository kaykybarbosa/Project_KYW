import 'package:flutter/material.dart';
import 'package:kyw_management/app/enums/status.dart';
import 'package:kyw_management/app/widgets/create_project_screen.dart/criation_input.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/filter_task/card_category.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/filter_task/filter_by_status.dart';

class FilterForTask extends StatefulWidget {
  const FilterForTask({super.key, required this.categoryController});

  final TextEditingController categoryController;

  @override
  State<FilterForTask> createState() => _FilterForTaskState();
}

class _FilterForTaskState extends State<FilterForTask> {
  bool _complete = false;
  bool _pending = false;
  bool _incomplete = false;
  bool _myCategory = false;

  void _setStatusTask({required Status status, bool? value}) {
    setState(() {
      if (value != null) {
        if (status == Status.complete) {
          _complete = value;
        } else if (status == Status.incomplete) {
          _incomplete = value;
        } else {
          _pending = value;
        }
      }
    });
  }

  void _setMyCategory({bool wasClicked = false}) {
    setState(() {
      _myCategory = wasClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The three Status CheckBox
        const Text(
          'Status',
          style: TextStyle(fontSize: 20.0),
        ),
        FilterByCheckedBox(
          isChecked: _pending,
          status: Status.pending,
          onChanged: (value) {
            _setStatusTask(
              status: Status.pending,
              value: value,
            );
          },
        ),
        FilterByCheckedBox(
          isChecked: _complete,
          status: Status.complete,
          onChanged: (value) {
            _setStatusTask(
              status: Status.complete,
              value: value,
            );
          },
        ),
        FilterByCheckedBox(
          isChecked: _incomplete,
          status: Status.incomplete,
          onChanged: (value) {
            _setStatusTask(
              status: Status.incomplete,
              value: value,
            );
          },
        ),

        const SizedBox(height: 20.0),

        // Category
        const Text(
          'Category',
          style: TextStyle(fontSize: 20.0),
        ),

        // CheckBox with Show categories
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FilterByCheckedBox(
              statusIsVisible: false,
              isChecked: _myCategory,
              onChanged: (value) {
                _setMyCategory(wasClicked: value);
              },
            ),
            const Text(
              'Mostrar apenas minhas categorias',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),

        // Input select categories
        MyCreationInput(
          text: '',
          showText: false,
          controller: widget.categoryController,
          placeHolder: 'Inserir categoria',
          maxLine: 2,
          heightPrefix: 56.0,
          validation: (category) {},
        ),

        const SizedBox(height: 25.0),

        // Cards categories
        const Wrap(
          runSpacing: 12.0,
          children: [
            CardCategory(
              category: 'Atividades',
            ),
            CardCategory(
              category: 'Trabalho',
            ),
            CardCategory(
              category: 'Estudo',
            ),
            CardCategory(
              category: 'Some orther category',
            ),
          ],
        )
      ],
    );
  }
}
