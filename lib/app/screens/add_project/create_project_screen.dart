import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/enums/my_routes.dart';
import 'package:kyw_management/app/widgets/circle_image.dart';
import 'package:kyw_management/app/widgets/create_project_screen.dart/criation_input.dart';
import 'package:kyw_management/domain/blocs/add_project_bloc/add_project_bloc.dart';

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
              vertical: 20.0,
              horizontal: 35.0,
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
      'Selecione uma imagem pra o projeto',
      style: TextStyle(
        fontSize: 18.0,
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
        return CupertinoFormRow(
          padding: EdgeInsets.zero,
          helper: state.title.displayError != null
              ? const _MessageValidationError(
                  messageError: 'Título é obrigátorio!')
              : null,
          child: MyCreationInput(
            text: 'Título do Projeto*',
            placeHolder: 'Título',
            textInputType: TextInputType.text,
            maxLength: 30,
            onChange: (value) => context
                .read<AddProjectBloc>()
                .add(TitleChangedAddProject(title: value)),
          ),
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
        return CupertinoFormRow(
          padding: EdgeInsets.zero,
          helper: state.description.displayError != null
              ? const _MessageValidationError(
                  messageError: 'Descrição é obrigátorio!')
              : null,
          child: MyCreationInput(
            text: 'Descrição do Projeto*',
            placeHolder: 'Descrição',
            heightPrefix: 115.8,
            maxLine: 5,
            maxLength: 100,
            textInputType: TextInputType.multiline,
            onChange: (value) {
              context
                  .read<AddProjectBloc>()
                  .add(DescriptionChangedAddProject(description: value));
            },
          ),
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
          onPressed:
              state.isValid ? () => context.push(MyRoutes.inviteFriends) : null,
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            CupertinoIcons.arrow_right,
            size: 30.0,
            color: CupertinoColors.white,
          ),
        );
      },
    );
  }
}

class _MessageValidationError extends StatelessWidget {
  const _MessageValidationError({required String messageError})
      : _messageError = messageError;

  final String _messageError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        _messageError,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 14,
        ),
      ),
    );
  }
}
