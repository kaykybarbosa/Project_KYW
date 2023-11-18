import 'package:flutter/cupertino.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(),
        navigationBar: CupertinoNavigationBar(
          middle: Text('KYW'),
        ));
  }
}
