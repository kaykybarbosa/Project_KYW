import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/domain/enums/snack_bar_type.dart';
import 'package:kyw_management/ui/screens/authentication/widgets/my_title.dart';
import 'package:kyw_management/ui/state_management/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:kyw_management/ui/widgets/back_button_ios.dart';
import 'package:kyw_management/ui/widgets/my_password_text_field.dart';
import 'package:kyw_management/ui/widgets/my_text_field.dart';
import 'package:kyw_management/ui/widgets/submit_button.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/snack_bar/snack_bar_custom.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocListener<SignInCubit, SignInState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (_, state) {
          if (state.status.isSuccess) {
            Get.offAllNamed(AppRoutes.home);
          } else if (state.status.isFailure) {
            snackBarCustom(
              message: state.errorMessage,
              type: SnackBarType.danger,
            );
          }
        },
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              /// Body
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        /// -- Título
                        const MyTitle(title: 'Acessar conta'),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            /// -- E-mail
                            const _EmailInput(),

                            /// -- Senha
                            const _PasswordInput(),

                            /// -- Esqueceu senha
                            _ForgotPassword(onTap: () => Get.toNamed(AppRoutes.forgotPassword)),

                            const Gap(40),

                            /// -- Botão de acesso
                            const _SubmitButton(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /// Botão de voltar
              const BackButtonIOS(),
            ],
          ),
        ),
      );
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) => BlocBuilder<SignInCubit, SignInState>(
        buildWhen: (previous, current) => previous.email.value != current.email.value,
        builder: (context, state) => Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: MyTextFormField(
            initialValue: state.email.value,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            hintText: 'E-mail',
            errorText: state.email.displayError,
            onChanged: (email) => context.read<SignInCubit>().emailChanged(email),
          ),
        ),
      );
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) => BlocBuilder<SignInCubit, SignInState>(
        buildWhen: (previous, current) =>
            previous.password.value != current.password.value || previous.obscureText != current.obscureText,
        builder: (context, state) => MyPasswordTextField(
          hintText: 'Senha',
          initialValue: state.password.value,
          errorText: state.password.displayError,
          obscureText: state.obscureText,
          suffixOnTap: () => context.read<SignInCubit>().obscureChanged(),
          onChanged: (password) => context.read<SignInCubit>().passwordChanged(password),
        ),
      );
}

class _ForgotPassword extends StatelessWidget {
  const _ForgotPassword({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onTap,
        child: const Text(
          'Esqueceu a senha ?',
          textAlign: TextAlign.start,
          style: TextStyle(color: TColors.primary),
        ),
      );
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) => BlocBuilder<SignInCubit, SignInState>(
        builder: (context, state) => SubmitButton(
          label: 'Acessar',
          isInProgress: state.status.isInProgress,
          onPressed: state.isValid
              ? () => {FocusScope.of(context).unfocus(), context.read<SignInCubit>().formSubmitted()}
              : null,
        ),
      );
}
