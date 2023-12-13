import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/data/users.dart';
import 'package:kyw_management/app/enums/my_routes.dart';
import 'package:kyw_management/app/models/user.dart';
import 'package:kyw_management/app/validation/input_validator.dart';
import 'package:kyw_management/app/widgets/circle_image.dart';
import 'package:kyw_management/app/widgets/create_project_screen.dart/title_description_inputs.dart';
import 'package:kyw_management/app/widgets/create_project_screen.dart/list_members.dart';
import 'package:kyw_management/app/widgets/create_project_screen.dart/criation_input.dart';
import 'package:kyw_management/domain/cubits/add_project_cubit/add_project_cubit.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

/// Firs Step the creation project
/// enter with [Title] and [Description]
/// and [Image] optional
class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _emailController = TextEditingController();

  bool _firstStep = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProjectCubit(),
      child: BlocBuilder<AddProjectCubit, AddProjectState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0.0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text(
                'Novo Projeto',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 35.0,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Select the image text
                      const Text(
                        'Selecione uma imagem pra o projeto',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),

                      const SizedBox(height: 15.0),

                      // Circle the image
                      CircleImage(onTap: () {}),

                      const SizedBox(height: 30.0),

                      // Title with TitleInput
                      MyCreationInput(
                        text: 'Título do Projeto*',
                        placeHolder: 'Título',
                        controller: _titleController,
                        textInputType: TextInputType.text,
                        maxLength: 30,
                        onChange: (value) =>
                            context.read<AddProjectCubit>().titleChanged(value),
                        validation: (title) {
                          return InputValidator.validateTitle(title: title);
                        },
                      ),

                      const SizedBox(height: 30.0),

                      // Description with DescriptionInput
                      CupertinoFormRow(
                        padding: EdgeInsets.zero,
                        helper: state.description.displayError != null
                            ? const Text('Insira um descrição!')
                            : null,
                        child: MyCreationInput(
                          text: 'Descrição do Projeto*',
                          placeHolder: 'Descrição',
                          controller: _descriptionController,
                          heightPrefix: 115.8,
                          maxLine: 5,
                          maxLength: 100,
                          textInputType: TextInputType.multiline,
                          onChange: (value) {
                            context
                                .read<AddProjectCubit>()
                                .descriptionChanged(value);
                          },
                          validation: (description) {
                            return InputValidator.validateDescription(
                                description: description);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Button Create Project
            floatingActionButton: FloatingActionButton(
              onPressed: state.isValid ? () => _validatingField() : null,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                CupertinoIcons.arrow_right,
                size: 30.0,
                color: CupertinoColors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  void _validatingField() {
    // Adding project
    _addProject();
    GoRouter.of(context).push(MyRoutes.createProjectDescription);
  }
}

void _addProject() {}
