import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kyw_management/ui/state_management/blocs/filter_task_bloc/filter_task_bloc.dart';
import 'package:kyw_management/ui/state_management/models_states/my_category.dart';

class CardCategory extends StatefulWidget {
  const CardCategory({super.key, required this.category});

  final MyCategory category;

  @override
  State<CardCategory> createState() => _CardCategoryState();
}

class _CardCategoryState extends State<CardCategory> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<FilterTaskBloc>().add(UpdateCategory(category: widget.category)),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: widget.category.isCheck ? Colors.grey[800] : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        margin: const EdgeInsets.only(right: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              FontAwesomeIcons.x,
              color: widget.category.isCheck ? Colors.white : null,
              size: 14.0,
            ),
            const SizedBox(width: 4.0),
            Text(
              widget.category.name,
              style: TextStyle(
                fontSize: 16.0,
                color: widget.category.isCheck ? Colors.white : null,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
