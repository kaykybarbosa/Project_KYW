import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/data/users.dart';
import 'package:kyw_management/app/enums/my_routes.dart';
import 'package:kyw_management/app/models/project.dart';
import 'package:kyw_management/app/models/user.dart';
import 'package:kyw_management/app/validation/input_validator.dart';
import 'package:kyw_management/app/widgets/create_project_screen.dart/input_title_description.dart';
import 'package:kyw_management/app/widgets/create_project_screen.dart/list_members.dart';
import 'package:kyw_management/app/widgets/create_project_screen.dart/criation_input.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _emailController = TextEditingController();

  bool _firstStep = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoTheme.of(context).primaryColor,
        elevation: 0.0,
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
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: _firstStep
              ? const EdgeInsets.symmetric(vertical: 20.0, horizontal: 35.0)
              : EdgeInsets.zero,
          child: _firstStep

              /// Firs Step the creation project
              /// enter with [Title] and [Description]
              /// and [Image] optional
              ? SingleChildScrollView(
                  child: InputTitleAndDescription(
                    titleController: _titleController,
                    descriptionController: _descriptionController,
                  ),
                )
              : Column(
                  children: [
                    // Invite friends by e-mail text and input
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35.0, vertical: 25.0),
                      decoration: const BoxDecoration(
                        color: CupertinoColors.systemGrey4,
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.systemGrey3,
                            blurRadius: 6.0,
                            spreadRadius: 2.0,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CreationInput(
                                  placeHolder: 'Inserir e-mail',
                                  text: 'Convidar amigos por e-mail',
                                  controller: _emailController,
                                  onTap: () {},
                                  validation: (email) {
                                    var result = InputValidator.validateEmail(
                                      email: email,
                                      isRequired: false,
                                    );

                                    // If [result] valid, add members
                                    _addMembers(_emailController.text);

                                    return result;
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Guests
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Membros',
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                      SizedBox(height: 5.0),
                                      Divider(),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // List of invited members
                            Expanded(child: ListMembers(users: usersData))
                          ],
                        ),
                      ),
                    )

                    // Button Create Project
                  ],
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _validatingField();
        },
        backgroundColor: CupertinoTheme.of(context).primaryColor,
        child: Icon(
          _firstStep ? CupertinoIcons.arrow_right : FontAwesomeIcons.check,
          size: 30.0,
          color: CupertinoColors.white,
        ),
      ),
    );
  }

  void _validatingField() {
    if (_formKey.currentState!.validate()) {
      if (_firstStep) {
        setState(() {
          _firstStep = !_firstStep;
        });
      } else {
        // Adding project
        _addProject();
        GoRouter.of(context).pushReplacement(MyRoutes.home);
      }
    }
  }

  final List<User> _users = [];

  void _addMembers(String email) {
    setState(() {
      _users.add(User(name: email, email: email));
    });
  }

  void _addProject() {}
}
