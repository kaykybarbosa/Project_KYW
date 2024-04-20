import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/ui/screens/authentication/widgets/my_title.dart';
import 'package:kyw_management/ui/state_management/cubits/change_password_cubit/change_password_cubit.dart';
import 'package:kyw_management/ui/widgets/change_password_screen/change_confirmed_password_input.dart';
import 'package:kyw_management/ui/widgets/change_password_screen/change_password_input.dart';
import 'package:kyw_management/ui/widgets/change_password_screen/message_dont_change_password.dart';
import 'package:kyw_management/ui/widgets/change_password_screen/message_go_to_sign_in.dart';
import 'package:kyw_management/ui/widgets/change_password_screen/submit_change_password_button.dart';
import 'package:kyw_management/ui/widgets/change_password_screen/title_input.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmedPasswordController = TextEditingController();
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _passwordController.text = '';
    _confirmedPasswordController.text = '';
  }

  void _clearInputs() {
    _passwordController.text = '';
    _confirmedPasswordController.text = '';
  }

  void _changeVisible(bool value) {
    setState(() {
      _visible = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
            listener: (context, state) {
              if (state.status.isSuccess) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentMaterialBanner()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Senha alterada com sucesso!'),
                    ),
                  );

                _clearInputs();
                _changeVisible(false);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const MyTitle(title: 'CHANGE YOUR PASSWORD'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleInput(label: 'Entre com sua nova senha'),
                    ChangePasswordInput(passwordController: _passwordController),
                    const SizedBox(height: 15),
                    const TitleInput(label: 'Confirme a senha'),
                    ChangeConfirmedPasswordInput(
                      confirmedPasswordController: _confirmedPasswordController,
                    ),
                  ],
                ),
                const SubmitChangePasswordButton(),
                Visibility(
                  visible: _visible,
                  child: const MessageDontCreatePassword(),
                ),
                Visibility(
                  visible: !_visible,
                  child: const MessageGoToSignIn(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
