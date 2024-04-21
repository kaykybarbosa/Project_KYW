import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/my_routes.dart';
import 'package:kyw_management/ui/screens/authentication/widgets/my_title.dart';
import 'package:kyw_management/ui/state_management/cubits/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:kyw_management/ui/widgets/go_to_sign_in.dart';
import 'package:kyw_management/ui/widgets/my_text_field.dart';
import 'package:kyw_management/ui/widgets/submit_button.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => ForgotPasswordCubit(),
        child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              Get.toNamed(AppRoutes.codeForgotPassword);
            }
          },
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Gap(10),

                  /// Formulário
                  const Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          /// -- Título
                          MyTitle(title: 'Esqueceu a senha'),

                          /// -- E-mail
                          _EmailInput(),
                          Gap(40),

                          /// -- Botão de enviar
                          _SubmitButton(),
                        ],
                      ),
                    ),
                  ),

                  /// Acessar conta
                  GoToSignIn(onTap: () => Get.back()),
                ],
              ),
            ),
          ),
        ),
      );
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) => BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
        buildWhen: (previous, current) => previous.email.value != current.email.value,
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// Título
            const Text(
              'Digite o e-mail cadastrado em sua conta',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: TColors.base300,
                fontSize: TConstants.fontSizeMd - 1,
              ),
            ),
            const Gap(5),

            /// Input
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: MyTextFormField(
                hintText: 'E-mail',
                initialValue: state.email.value,
                keyboardType: TextInputType.emailAddress,
                errorText: state.email.displayError,
                onChanged: (email) => context.read<ForgotPasswordCubit>().emailChanged(email),
              ),
            ),
          ],
        ),
      );
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) => BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
        builder: (context, state) => SubmitButton(
          label: 'Enviar código',
          isInProgress: state.status.isInProgress,
          onPressed: state.isValid ? () => context.read<ForgotPasswordCubit>().formSubmitted() : null,
        ),
      );
}
