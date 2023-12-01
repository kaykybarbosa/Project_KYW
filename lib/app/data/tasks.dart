import 'package:kyw_management/app/enums/status.dart';
import 'package:kyw_management/app/models/task.dart';

final List<Task> tasksData = [
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
];
