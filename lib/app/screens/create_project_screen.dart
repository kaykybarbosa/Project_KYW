import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/enums/my_routes.dart';
import 'package:kyw_management/app/validation/input_validator.dart';
import 'package:kyw_management/app/widgets/create_project_screen.dart/circle_image.dart';
import 'package:kyw_management/app/widgets/create_project_screen.dart/input_title_description.dart';
import 'package:kyw_management/app/widgets/create_project_screen.dart/title_input.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _firstStep = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: CupertinoColors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Novo Projeto',
          style: TextStyle(
            fontSize: 25.0,
            color: CupertinoColors.white,
          ),
        ),
        backgroundColor: CupertinoTheme.of(context).primaryColor,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 35.0),
            child: Center(
              child: _firstStep
                  ? const InputTitleAndDescription()
                  : Column(
                      children: [
                        // Invite friends text
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CreationInput(
                                    placeHolder: 'Inserir e-mail',
                                    text: 'Convidar amigos por e-mail',
                                    onTap: () {},
                                    validation: () {},
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                        // EmailInput

                        // Guests

                        // Button Create Project
                      ],
                    ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _validatinField();
        },
        backgroundColor: CupertinoTheme.of(context).primaryColor,
        child: const Icon(
          CupertinoIcons.arrow_right,
          size: 30.0,
          color: CupertinoColors.white,
        ),
      ),
    );
  }

  void _validatinField() {
    if (_formKey.currentState!.validate()) {
      print('ALID');
      context.push(MyRoutes.home);
    }
  }
}
