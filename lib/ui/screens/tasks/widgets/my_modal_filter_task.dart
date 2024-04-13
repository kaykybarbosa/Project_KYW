import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kyw_management/domain/enums/filters_enum.dart';
import 'package:kyw_management/domain/enums/status.dart';
import 'package:kyw_management/ui/state_management/blocs/filter_task_bloc/filter_task_bloc.dart';
import 'package:kyw_management/ui/widgets/apply_button.dart';
import 'package:kyw_management/ui/widgets/create_project_screen.dart/my_text_field.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/card_category.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/filter_buttons.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/select_date_create.dart';
import 'package:kyw_management/ui/widgets/my_card_status.dart';
import 'package:kyw_management/ui/widgets/my_draggable_scroll.dart';
import 'package:kyw_management/ui/widgets/section_title.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/texts.dart';

class MyModalFilterTask extends StatelessWidget {
  const MyModalFilterTask({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<FilterTaskBloc, FilterTaskState>(
        builder: (context, state) => Column(
          children: <Widget>[
            /// Body
            Expanded(
              child: MyDraggableScroll(
                /// -- Botões de actions
                header: FilterButtons(
                  current: FilterEnum.Filter,
                  clearFunction: () {},
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Gap(15),

                    /// -- Seleção da data de criação
                    SelectDateCreate(
                      onInitDatePicker: (date) {},
                      onFinalDatePicker: (date) {},
                    ),
                    const Gap(20),

                    /// -- Título status
                    const SectionTitle(title: TTexts.status),

                    /// -- Status
                    _FilterByCheckedBox(
                      isChecked: false,
                      status: TaskStatus.pending,
                      onChanged: (value) => {},
                    ),
                    _FilterByCheckedBox(
                      isChecked: false,
                      status: TaskStatus.complete,
                      onChanged: (value) => {},
                    ),
                    _FilterByCheckedBox(
                      isChecked: false,
                      status: TaskStatus.incomplete,
                      onChanged: (value) => {},
                    ),

                    const Gap(15),

                    /// -- Título categoria
                    const SectionTitle(title: TTexts.category),

                    /// -- CheckBox minha categoria
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Checkbox(
                          value: false,
                          onChanged: (value) => {},
                        ),
                        const Flexible(
                          child: Text(
                            TTexts.showOnlyMyCategories,
                            style: TextStyle(
                              fontSize: TConstants.fontSizeLg,
                              color: TColors.base200,
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// -- Input para inserir categoria
                    const MyTextField(
                      showText: false,
                      placeHolder: TTexts.labelCategory,
                      maxLine: 1,
                    ),

                    const Gap(10.0),

                    /// -- Card das categorias
                    Wrap(
                      runSpacing: 10.0,
                      children: state.categories.map((e) => CardCategory(category: e)).toList(),
                    ),

                    const Gap(10.0),
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

            /// Espaço do teclado
            Gap(MediaQuery.of(context).viewInsets.bottom)
          ],
        ),
      );
}

class _FilterByCheckedBox extends StatelessWidget {
  const _FilterByCheckedBox({
    this.status,
    required this.onChanged,
    this.isChecked,
  });

  final bool? isChecked;
  final TaskStatus? status;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          Checkbox(
            value: isChecked,
            onChanged: (bool? value) => onChanged(value),
          ),
          MyCardStatus(status: status ?? TaskStatus.incomplete)
        ],
      );
}
