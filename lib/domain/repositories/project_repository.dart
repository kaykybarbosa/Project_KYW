// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:kyw_management/app/models/project.dart';

class ProjectRepository {
  final List<Project> _projects = [
    Project(
      name: 'Casa na Árvore',
      image: 'assets/casa-na-arvore.webp',
      lastMessage: 'última mensagem envia...',
      lastMessageTime: '12:25',
      isImportant: true,
    ),
    Project(
      name: 'Projeto do Milhão',
      lastMessage: 'última mensagem envia...',
      lastMessageTime: '14:32',
    ),
  ];

  List<Project> get projects => _projects;
}
