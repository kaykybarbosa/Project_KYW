import 'package:flutter/cupertino.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/filter_projet/filter_with_check.dart';

class FilterForProject extends StatefulWidget {
  const FilterForProject({super.key});

  @override
  State<FilterForProject> createState() => _FilterForProjectState();
}

class _FilterForProjectState extends State<FilterForProject> {
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
