import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/my_routes.dart';
import 'package:kyw_management/ui/state_management/blocs/add_project_bloc/add_project_bloc.dart';
import 'package:kyw_management/ui/widgets/circle_image.dart';
import 'package:kyw_management/ui/widgets/create_project_screen.dart/my_text_field.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

/// Firs Step the creation project
/// enter with [Title] and [Description]
/// and [Image] optional
class _CreateProjectScreenState extends State<CreateProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProjectBloc, AddProjectState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Novo Projeto')),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 35,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const _MessageTop(),
                  const SizedBox(height: 15),
                  CircleImage(onTap: () {}),
                  const SizedBox(height: 30),
                  const _TitleInput(),
                  const SizedBox(height: 30),
                  const _DescriptionInput(),
                ],
              ),
            ),
          ),
          floatingActionButton: const _MyFloatingButton(),
        );
      },
    );
  }
}

class _MessageTop extends StatelessWidget {
  const _MessageTop();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Selecione uma imagem para o projeto',
      style: TextStyle(
        fontSize: 17.0,
        color: CupertinoColors.systemGrey,
      ),
    );
  }
}

class _TitleInput extends StatelessWidget {
  const _TitleInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProjectBloc, AddProjectState>(
      builder: (context, state) {
        return MyTextField(
          text: 'Título do Projeto*',
          placeHolder: 'Título',
          textInputType: TextInputType.text,
          onChange: (value) => context.read<AddProjectBloc>().add(TitleChangedAddProject(title: value)),
          errorMessage: state.title.displayError != null ? 'Título é obrigátorio!' : null,
        );
      },
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  const _DescriptionInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProjectBloc, AddProjectState>(
      builder: (context, state) {
        return MyTextField(
          text: 'Descrição do Projeto*',
          placeHolder: 'Descrição',
          maxLine: 5,
          textInputType: TextInputType.multiline,
          onChange: (value) {
            context.read<AddProjectBloc>().add(DescriptionChangedAddProject(description: value));
          },
          errorMessage: state.description.displayError != null ? 'Descrição é obrigátorio!' : null,
        );
      },
    );
  }
}

class _MyFloatingButton extends StatelessWidget {
  const _MyFloatingButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProjectBloc, AddProjectState>(
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: state.isValid ? () => Get.toNamed(AppRoutes.inviteFriends) : null,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            CupertinoIcons.arrow_right,
            size: 30.0,
            color: state.isValid ? Colors.white : Colors.white60,
          ),
        );
      },
    );
  }
}
