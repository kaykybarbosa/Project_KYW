import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListMembers extends StatelessWidget {
  const ListMembers({super.key, required this.users});

  final List<String> users;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: ((context, index) {
        return ListTile(
          title: Text(
            users[index],
            style: const TextStyle(fontSize: 18.0),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
