// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:kyw_management/app/enums/status.dart';
import 'package:kyw_management/app/models/project.dart';
import 'package:kyw_management/app/models/task.dart';
import 'package:kyw_management/app/models/user_test.dart';

class ProjectRepository {
  final List<Task> tasks = [
    Task(
      title: 'Escolher os materiais',
      description: 'Alguma descrição aqui',
      status: Status.complete,
    ),
    Task(
      title: 'Pesquisar a cor',
      description: 'Alguma descrição aqui',
      isImportant: true,
      status: Status.incomplete,
    ),
    Task(
      title: 'Fazer o acabamento',
      description: 'Alguma descrição aqui',
      status: Status.pending,
    ),
  ];

  final List<Project> _projects = [
    Project(
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
          status: Status.complete,
        ),
        Task(
          title: 'Pesquisar a cor',
          description: 'Alguma descrição aqui',
          isImportant: true,
          status: Status.incomplete,
        ),
        Task(
          title: 'Fazer o acabamento',
          description: 'Alguma descrição aqui',
        ),
        Task(
          title: 'Realizar a pintura da porta',
          description: 'Alguma descrição aqui',
        ),
      ],
    ),
    Project(
      name: 'Projeto do Milhão',
      lastMessage: 'última mensagem envia...',
      lastMessageTime: '14:32',
    ),
  ];

  List<Project> get projects => _projects;
}
