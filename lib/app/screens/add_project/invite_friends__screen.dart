import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/enums/my_routes.dart';
import 'package:kyw_management/app/models/project.dart';
import 'package:kyw_management/app/widgets/create_project_screen.dart/my_text_field.dart';
import 'package:kyw_management/app/widgets/create_project_screen.dart/list_members.dart';
import 'package:kyw_management/domain/blocs/blocs_export.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Projeto')),
      body: BlocBuilder<AddProjectBloc, AddProjectState>(
        builder: (context, state) {
          return Column(
            children: [
              // Invite friends by e-mail text and input
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 30, top: 20, right: 30),
                decoration: const BoxDecoration(
                  color: CupertinoColors.systemGrey4,
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey3,
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _EmailFriendsInput(),
                    _AddFriendsButton(),
                  ],
                ),
              ),

              // Guests
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20.0,
                  ),
                  child: Column(
                    children: [
                      const _HeaderInvitedFriends(),

                      // List of invited members
                      Expanded(
                        flex: 11,
                        child: ListMembers(
                          users:
                              state.invitedFriends.map((e) => e.value).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: const _MyFloatingButton(),
    );
  }
}

class _HeaderInvitedFriends extends StatelessWidget {
  const _HeaderInvitedFriends();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Membros',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        Divider(
          height: 0,
          color: Colors.grey,
        ),
      ],
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
          onPressed: state.isValid
              ? () {
                  _completingAdditionProject(context, state);
                }
              : null,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            CupertinoIcons.check_mark,
            size: 30.0,
            color: state.isValid ? Colors.white : Colors.white60,
          ),
        );
      },
    );
  }

  void _completingAdditionProject(BuildContext context, AddProjectState state) {
    context
        .read<ProjectBloc>()
        .add(AddProject(project: Project(name: state.title.value)));
    context.read<AddProjectBloc>().add(FormSubmitteddAddProject());
    GoRouter.of(context).pushReplacement(MyRoutes.home);
  }
}

class _EmailFriendsInput extends StatelessWidget {
  const _EmailFriendsInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProjectBloc, AddProjectState>(
      builder: (context, state) {
        return MyTextField(
          placeHolder: 'Inserir e-mail',
          text: 'Convidar amigos por e-mail',
          textInputType: TextInputType.emailAddress,
          onChange: (value) => context
              .read<AddProjectBloc>()
              .add(EmailChangedAddProject(email: value)),
          errorMessage:
              state.email.displayError != null ? 'E-mail inválido!' : null,
        );
      },
    );
  }
}

class _AddFriendsButton extends StatelessWidget {
  const _AddFriendsButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProjectBloc, AddProjectState>(
      builder: (context, state) {
        return TextButton(
          onPressed: () =>
              context.read<AddProjectBloc>().add(InvitedFriendsAddProject()),
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 10)),
          ),
          child: Chip(
            padding: EdgeInsets.zero,
            backgroundColor: Theme.of(context).primaryColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              side: BorderSide(color: Colors.transparent),
            ),
            label: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
                Text(
                  'Convidar',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
