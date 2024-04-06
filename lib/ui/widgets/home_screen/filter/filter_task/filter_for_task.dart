import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/domain/enums/status.dart';
import 'package:kyw_management/ui/state_management/blocs/filter_task_bloc/filter_task_bloc.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/filter_task/card_category.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/filter_task/filter_by_status.dart';

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
            const _Title(title: 'Status'),
            FilterByCheckedBox(
              isChecked: state.pending,
              status: TaskStatus.pending,
              onChanged: (value) => context.read<FilterTaskBloc>().add(PendingChanged()),
            ),
            FilterByCheckedBox(
              isChecked: state.complete,
              status: TaskStatus.complete,
              onChanged: (value) => context.read<FilterTaskBloc>().add(CompleteChanged()),
            ),
            FilterByCheckedBox(
              isChecked: state.incomplete,
              status: TaskStatus.incomplete,
              onChanged: (value) => context.read<FilterTaskBloc>().add(IncompleteChanged()),
            ),

            const SizedBox(height: 20),

            // Category
            const _Title(title: 'Categoria'),

            // CheckBox with Show categories
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FilterByCheckedBox(
                  statusIsVisible: false,
                  isChecked: state.showMyCategories,
                  onChanged: (value) => context.read<FilterTaskBloc>().add(ShowMyCategoriesChanged()),
                ),
                const Text(
                  'Mostrar apenas minhas categorias',
                  style: TextStyle(fontSize: 16),
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

class _Title extends StatelessWidget {
  const _Title({required String title}) : _title = title;

  final String _title;

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
