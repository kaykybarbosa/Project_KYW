import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kyw_management/ui/state_management/blocs/filter_project_bloc/filter_project_bloc.dart';
import 'package:kyw_management/ui/widgets/apply_button.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/filter_header.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/filter_projet/filter_with_check.dart';
import 'package:kyw_management/utils/formaters.dart';
import 'package:kyw_management/utils/texts.dart';

class MyModalFilterProject extends StatelessWidget {
  const MyModalFilterProject({super.key});

  @override
  Widget build(BuildContext context) {
    void setDate({
      required bool isInitDate,
      DateTime? dateSelected,
    }) {
      if (dateSelected != null) {
        var date = Formaters.formatDate(dateSelected);
        if (isInitDate) {
          context.read<FilterProjectBloc>().add(InitDateChanged(initDate: date));
        } else {
          context.read<FilterProjectBloc>().add(FinalDateChanged(finalDate: date));
        }
      }
    }

    void clearFilter(BuildContext context) {
      context.read<FilterProjectBloc>().add(ResetFilterProject());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: BlocBuilder<FilterProjectBloc, FilterProjectState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  /// Filtros e Seleção da data de criação
                  FilterHeader(
                    onInitDatePicker: (date) => setDate(
                      isInitDate: state.isInitDate,
                      dateSelected: date,
                    ),
                    onFinalDatePicker: (date) => setDate(
                      isInitDate: !state.isInitDate,
                      dateSelected: date,
                    ),
                    onClean: () => clearFilter(context),
                  ),

                  const Gap(30),

                  /// -- Projetos criados por me
                  FilterWithCheck(
                    label: TTexts.createdByMe,
                    isChecked: state.createdByMe,
                    onChanged: (value) => context.read<FilterProjectBloc>().add(CreatedByMeChanged()),
                  ),

                  const Gap(25.0),

                  ///  -- Projetos marcados
                  FilterWithCheck(
                    label: TTexts.marked,
                    isChecked: state.marked,
                    onChanged: (value) => context.read<FilterProjectBloc>().add(MarkedChanged()),
                  ),
                ],
              ),

              // Aplicar filtro
              ApplyButtom(onPressed: () {}),
            ],
          );
        },
      ),
    );
  }
}
