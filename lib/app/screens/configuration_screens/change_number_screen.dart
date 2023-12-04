import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/widgets/base/my_scaffold.dart';
import 'package:kyw_management/app/widgets/configuration_screen/account_button_main.dart';
import 'package:kyw_management/app/widgets/configuration_screen/account_input.dart';

class ChangeNumberScreen extends StatelessWidget {
  const ChangeNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return MyScaffold(
      arrowBack: () {
        context.pop(context);
      },
      title: 'Mudar número',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
        child: Form(
            child: SingleChildScrollView(
          // physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: (screenSize.height / 1.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text new number
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: Text(
                        'Insira seu número novo',
                        style: TextStyle(fontSize: 19.0),
                      ),
                    ),

                    // Input new number
                    AccountInput(
                      placeHolder: 'Número novo',
                      validator: () {},
                    ),

                    const SizedBox(height: 20.0),

                    // Text old number
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Insira seu número atual',
                        style: TextStyle(fontSize: 19.0),
                      ),
                    ),

                    // Imput old number
                    AccountInput(
                      placeHolder: 'Número atual',
                      validator: () {},
                    ),
                  ],
                ),

                // Button change number
                AccountButtonMain(
                  label: 'Mudar Número',
                  onTap: () {},
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
