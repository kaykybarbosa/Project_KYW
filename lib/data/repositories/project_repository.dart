import 'package:flutter_guid/flutter_guid.dart';
import 'package:kyw_management/domain/enums/status.dart';
import 'package:kyw_management/domain/models/project.dart';
import 'package:kyw_management/domain/models/task.dart';
import 'package:kyw_management/domain/models/user_test.dart';

class ProjectRepository {
  final List<Project> _projects = [
    Project(
      id: Guid.newGuid.toString(),
      name: 'Casa na Árvore',
      image: 'assets/casa-na-arvore.webp',
      lastMessage: 'última mensagem envia...',
      lastMessageTime: '12:25',
      isImportant: true,
      users: [
        UserTest(name: 'Yuri', email: 'yuri@gamil.com', isAdmin: true),
        UserTest(name: 'Wesle', email: 'wesle@gamil.com', isAdmin: false),
        UserTest(name: 'Kayky', email: 'kbuloso@gamil.com', isAdmin: false),
      ],
      tasks: [
        Task(
          title: 'Escolher os materiais',
          description: 'Alguma descrição aqui',
          status: TaskStatus.complete,
        ),
        Task(
          title: 'Pesquisar a cor',
          description: 'Alguma descrição aqui',
          isImportant: true,
        ),
        Task(
          title: 'Fazer o acabamento',
          description: 'Alguma descrição aqui',
        ),
        Task(
          title: 'Realizar a pintura da porta',
          description: 'Alguma descrição aqui',
          status: TaskStatus.pending,
        ),
      ],
    ),
    Project(
      id: Guid.newGuid.toString(),
      name: 'Projeto do Milhão',
      lastMessage: 'última mensagem envia...',
      lastMessageTime: '14:32',
    ),
  ];

  List<Project> get projects => _projects;
}
