import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/widgets/base/my_scaffold.dart';
import 'package:kyw_management/app/widgets/configuration_screen/account_input.dart';

class ChangeNumberScreen extends StatelessWidget {
  const ChangeNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      arrowBack: () {
        context.pop(context);
      },
      title: 'Mudar número',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
            child: Column(
          children: [
            // Text new number

            // Input new number
            AccountInput(
              placeHolder: 'Número novo',
              validator: () {},
            ),

            // Text old number

            // Imput old number
            AccountInput(
              placeHolder: 'Número atual',
              validator: () {},
            ),

            // Button change number
          ],
        )),
      ),
    );
  }
}
