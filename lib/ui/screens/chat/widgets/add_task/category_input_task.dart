import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/domain/enums/status.dart';

import '../../../../state_management/cubits/add_task_cubit/add_task_cubit.dart';

class CategoryInputTask extends StatelessWidget {
  CategoryInputTask({super.key});

  final List<TaskStatus> status = [
    TaskStatus.pending,
    TaskStatus.complete,
    TaskStatus.incomplete,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskCubit, AddTaskState>(
      buildWhen: (previous, current) => previous.category != current.category,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Title(),
              _CategoryListRadio(status: status),
            ],
          ),
        );
      },
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, bottom: 4),
      child: Text(
        'Categoria*',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

class _CategoryListRadio extends StatelessWidget {
  const _CategoryListRadio({required this.status});

  final List<TaskStatus> status;

  @override
  Widget build(BuildContext context) {
    var border = const BorderSide(color: Colors.grey, width: 1.5);
    return Container(
      padding: const EdgeInsets.only(left: 5),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(top: border, right: border, bottom: border),
          borderRadius: BorderRadius.circular(5),
        ),
        child: ExpansionPanelList.radio(
          expandIconColor: Colors.blue[700],
          expandedHeaderPadding: EdgeInsets.zero,
          animationDuration: const Duration(milliseconds: 350),
          children: [
            ExpansionPanelRadio(
              canTapOnHeader: true,
              value: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              headerBuilder: (context, isOpen) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: BlocBuilder<AddTaskCubit, AddTaskState>(
                  builder: (context, state) {
                    return Text(
                      state.category.value.isNotEmpty ? state.category.value : 'Selecione a categoria',
                      style: TextStyle(
                        color: state.category.value.isNotEmpty ? Theme.of(context).primaryColor : Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ),
              body: Column(
                children: [
                  // Items radio
                  Column(children: status.map((status) => _PanelRadioItems(status: status)).toList()),
                  // Add category
                  const _AddCategoryRadioItem(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddCategoryRadioItem extends StatelessWidget {
  const _AddCategoryRadioItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.grey))),
      child: ListTile(
        title: Text(
          'Adicionar categoria',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue[700],
          ),
        ),
        trailing: Icon(
          Icons.add,
          color: Colors.blue[700],
        ),
      ),
    );
  }
}

class _PanelRadioItems extends StatelessWidget {
  const _PanelRadioItems({
    required TaskStatus status,
  }) : _status = status;

  final TaskStatus _status;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.grey))),
      child: ListTile(
        title: Text(_status.name),
        onTap: () => context.read<AddTaskCubit>().categoryChanged(_status.name),
      ),
    );
  }
}
