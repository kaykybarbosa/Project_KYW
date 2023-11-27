import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/app/enums/status.dart';
import 'package:kyw_management/app/widgets/task.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Task(
          title: 'Apresentar Projeto',
          description:
              'Descrição da tarefa pode ficar grande a dessds dsd sd scricao',
          isImportant: true,
        ),
        Task(
          title: 'Fazer Orçamento',
          description: 'Buscar os melhores valores dos materiais',
          status: Status.complete,
        ),
        Task(
          title: 'Revisão do Projeto',
          description: 'Verificar e ajustar caso precise',
          status: Status.pending,
        ),
        Task(
          title: 'Apresentar Projeto',
          description:
              'Descrição da tarefa pode ficar grande a dessds dsd sd scricao',
          isImportant: true,
        ),
        Task(
          title: 'Fazer Orçamento',
          description: 'Buscar os melhores valores dos materiais',
          status: Status.complete,
        ),
        Task(
          title: 'Revisão do Projeto',
          description: 'Verificar e ajustar caso precise',
          status: Status.pending,
        ),
      ],
    );
  }
}
