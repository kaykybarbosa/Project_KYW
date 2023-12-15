import 'package:flutter/material.dart';
import 'package:kyw_management/app/enums/status.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/filter_task/card_category.dart';
import 'package:kyw_management/app/widgets/home_screen/filter/filter_task/filter_by_status.dart';

import '../../../../../domain/blocs/blocs_export.dart';

class FilterForTask extends StatelessWidget {
  const FilterForTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterTaskBloc, FilterTaskState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // The three Status CheckBox
            const Text(
              'Status',
              style: TextStyle(fontSize: 20.0),
            ),
            FilterByCheckedBox(
              isChecked: state.pending,
              status: Status.pending,
              onChanged: (value) =>
                  context.read<FilterTaskBloc>().add(PendingChanged()),
            ),
            FilterByCheckedBox(
              isChecked: state.complete,
              status: Status.complete,
              onChanged: (value) =>
                  context.read<FilterTaskBloc>().add(CompleteChanged()),
            ),
            FilterByCheckedBox(
              isChecked: state.incomplete,
              status: Status.incomplete,
              onChanged: (value) =>
                  context.read<FilterTaskBloc>().add(IncompleteChanged()),
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
                  isChecked: state.showMyCategories,
                  onChanged: (value) => context
                      .read<FilterTaskBloc>()
                      .add(ShowMyCategoriesChanged()),
                ),
                const Text(
                  'Mostrar apenas minhas categorias',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),

            // Input select categories
            // const MyCreationInput(
            //   text: '',
            //   showText: false,
            //   placeHolder: 'Inserir categoria',
            //   maxLine: 2,
            //   heightPrefix: 57.5,
            // ),

            const SizedBox(height: 10.0),

            // Cards categories
            Wrap(
              runSpacing: 10.0,
              children: state.categories.map((e) {
                return CardCategory(category: e);
              }).toList(),
            )
          ],
        );
      },
    );
  }
}
