import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/app/models/user.dart';

class ListMembers extends StatelessWidget {
  const ListMembers({super.key, required this.users});

  final List<UserTest> users;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: ((context, index) {
        return ListTile(
          title: Text(
            users[index].email,
            style: const TextStyle(fontSize: 18.0),
          ),
          trailing: const Icon(
            CupertinoIcons.ellipsis_vertical,
            color: CupertinoColors.systemBlue,
          ),
        );
      }),
      separatorBuilder: (__, _) => const Divider(
        height: 0,
        color: Colors.grey,
      ),
      itemCount: users.length,
      padding: EdgeInsets.zero,
    );
  }
}
