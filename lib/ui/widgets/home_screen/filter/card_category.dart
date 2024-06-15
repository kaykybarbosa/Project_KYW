import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kyw_management/domain/models/category_model.dart';
import 'package:kyw_management/ui/state_management/blocs/filter_task_bloc/filter_task_bloc.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/icons.dart';

class CardCategory extends StatefulWidget {
  const CardCategory({super.key, required this.category});

  final CategoryModel category;

  @override
  State<CardCategory> createState() => _CardCategoryState();
}

class _CardCategoryState extends State<CardCategory> {
  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => context.read<FilterTaskBloc>().add(UpdateCategory(category: widget.category)),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
          // border: Border.all(color: TColors.secondary),
          color: widget.category.isCheck ? colorScheme.primary : TColors.secondary.withOpacity(.18),
          borderRadius: BorderRadius.circular(TConstants.cardRadiusXs),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /// Ícone
            Icon(
              TIcons.xMarked,
              color: widget.category.isCheck ? TColors.base100 : TColors.secondary.withOpacity(.80),
              size: TConstants.iconXs,
            ),
            const Gap(4.0),

            /// Categoria
            Text(
              widget.category.name,
              style: TextStyle(
                fontSize: TConstants.fontSizeMd,
                color: widget.category.isCheck ? TColors.base100 : TColors.secondary.withOpacity(.71),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
