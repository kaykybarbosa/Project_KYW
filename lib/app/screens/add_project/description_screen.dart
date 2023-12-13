import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/app/data/users.dart';
import 'package:kyw_management/app/widgets/create_project_screen.dart/criation_input.dart';
import 'package:kyw_management/app/widgets/create_project_screen.dart/list_members.dart';

class DescriptionScreen extends StatelessWidget {
  const DescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Novo Projeto',
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          // Invite friends by e-mail text and input
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 35.0, vertical: 25.0),
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
                      MyCreationInput(
                        placeHolder: 'Inserir e-mail',
                        text: 'Convidar amigos por e-mail',
                        controller: TextEditingController(),
                        validation: () {},
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
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Column(
                children: [
                  const Column(
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
                  ),

                  // List of invited members
                  Expanded(
                    flex: 11,
                    child: ListMembers(users: usersData),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
