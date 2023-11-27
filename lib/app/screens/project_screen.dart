import 'package:flutter/cupertino.dart';
import 'package:kyw_management/app/widgets/project_group.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Project groups
        ProjectGroup(
          name: 'Casa na Árvore',
          image: Image.asset(
            'assets/casa-na-arvore.webp',
            width: 55.0,
          ),
          lastMessage: 'última mensagem envia...',
          lastMessageTime: '12:25',
          isImportant: true,
        ),
        ProjectGroup(
          name: 'Projeto do Milhão',
          lastMessage: 'última mensagem envia...',
          lastMessageTime: '14:32',
        )
      ],
    );
  }
}
