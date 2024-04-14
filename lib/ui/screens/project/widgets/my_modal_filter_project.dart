import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kyw_management/domain/enums/filters_enum.dart';
import 'package:kyw_management/ui/screens/project/widgets/filter_with_check.dart';
import 'package:kyw_management/ui/state_management/blocs/filter_project_bloc/filter_project_bloc.dart';
import 'package:kyw_management/ui/widgets/apply_button.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/filter_buttons.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/select_date_create.dart';
import 'package:kyw_management/ui/widgets/my_draggable_scroll.dart';
import 'package:kyw_management/utils/colors.dart';
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

    return BlocBuilder<FilterProjectBloc, FilterProjectState>(
      builder: (context, state) => Column(
        children: <Widget>[
          /// Body
          Expanded(
            child: MyDraggableScroll(
              /// -- Botões de actions
              header: FilterButtons(
                current: FilterEnum.Filter,
                clearFunction: () => clearFilter(context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Gap(20),

                  /// Filtros e Seleção da data de criação
                  SelectDateCreate(
                    onInitDatePicker: (date) => setDate(
                      isInitDate: state.isInitDate,
                      dateSelected: date,
                    ),
                    onFinalDatePicker: (date) => setDate(
                      isInitDate: !state.isInitDate,
                      dateSelected: date,
                    ),
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

                  const Gap(30)
                ],
              ),
            ),
          ),

          /// Aplicar filtro
          ApplyButtom(
            color: TColors.base100,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
