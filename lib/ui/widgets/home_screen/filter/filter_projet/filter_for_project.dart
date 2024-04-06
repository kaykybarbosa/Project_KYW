import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/filter_project_bloc/filter_project_bloc.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/filter_projet/filter_with_check.dart';

class FilterForProject extends StatelessWidget {
  const FilterForProject({super.key});

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
              onChanged: (value) => context.read<FilterProjectBloc>().add(CreatedByMeChanged()),
            ),

            const SizedBox(height: 25.0),

            // Onle marked
            FilterWithCheck(
              label: 'Marcados',
              isChecked: state.marked,
              onChanged: (value) => context.read<FilterProjectBloc>().add(MarkedChanged()),
            ),
          ],
        );
      },
    );
  }
}
