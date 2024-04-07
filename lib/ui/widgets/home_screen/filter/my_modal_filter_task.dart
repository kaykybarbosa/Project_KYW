import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kyw_management/domain/enums/status.dart';
import 'package:kyw_management/ui/state_management/blocs/filter_task_bloc/filter_task_bloc.dart';
import 'package:kyw_management/ui/widgets/apply_button.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/filter_header.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/filter_task/card_category.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/filter_task/filter_by_status.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/texts.dart';

class MyModalFilterTask extends StatelessWidget {
  const MyModalFilterTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterTaskBloc, FilterTaskState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// Filtros e Seleção da data de criação
                  FilterHeader(
                    onInitDatePicker: (date) {},
                    onFinalDatePicker: (date) {},
                    onClean: () {},
                  ),
                  const Gap(20),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /// Título status
                      const _Title(TTexts.status),

                      /// Status
                      FilterByCheckedBox(
                        isChecked: false,
                        status: TaskStatus.pending,
                        onChanged: (value) => {},
                      ),
                      FilterByCheckedBox(
                        isChecked: false,
                        status: TaskStatus.complete,
                        onChanged: (value) => {},
                      ),
                      FilterByCheckedBox(
                        isChecked: false,
                        status: TaskStatus.incomplete,
                        onChanged: (value) => {},
                      ),

                      const Gap(20),

                      /// Título categoria
                      const _Title(TTexts.category),

                      /// CheckBox minha categoria
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FilterByCheckedBox(
                            statusIsVisible: false,
                            isChecked: false,
                            onChanged: (value) => {},
                          ),
                          const Flexible(
                            child: Text(
                              TTexts.showOnlyMyCategories,
                              style: TextStyle(fontSize: TConstants.fontSizeMd),
                            ),
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

                      const Gap(10.0),

                      /// Card das categorias
                      Wrap(
                        runSpacing: 10.0,
                        children: state.categories.map((e) {
                          return CardCategory(category: e);
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
              // Aplicar filtro
              ApplyButtom(onPressed: () {}),
            ],
          ),
        );
      },
    );
  }
}

class _Title extends StatelessWidget {
  const _Title(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Text(
        title,
        style: const TextStyle(
          fontSize: TConstants.fontSizeLg + 2,
          fontWeight: FontWeight.w500,
        ),
      );
}
