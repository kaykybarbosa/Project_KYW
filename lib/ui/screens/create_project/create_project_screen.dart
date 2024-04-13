import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/my_routes.dart';
import 'package:kyw_management/ui/state_management/blocs/add_project_bloc/add_project_bloc.dart';
import 'package:kyw_management/ui/widgets/circle_image.dart';
import 'package:kyw_management/ui/widgets/create_project_screen.dart/my_text_field.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/icons.dart';
import 'package:kyw_management/utils/texts.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProjectBloc, AddProjectState>(
      builder: (_, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Novo Projeto')),
          body: const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: TConstants.defaultMargin,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  /// Título
                  _SelectImagemTitle(),
                  Gap(15),

                  /// Imagem do grupo
                  CircleImage(),
                  Gap(30),

                  /// Input do título
                  _TitleInput(),
                  Gap(30),

                  /// Input da descrição
                  _DescriptionInput(),
                ],
              ),
            ),
          ),
          floatingActionButton: const _MyFloatingButton(),
        );
      },
    );
  }
}

class _SelectImagemTitle extends StatelessWidget {
  const _SelectImagemTitle();

  @override
  Widget build(BuildContext context) => const Text(
        TTexts.selectImagemTitle,
        style: TextStyle(
          fontSize: TConstants.fontSizeLg - 1,
          color: TColors.secondary_600,
        ),
      );
}

class _TitleInput extends StatelessWidget {
  const _TitleInput();

  @override
  Widget build(BuildContext context) => BlocBuilder<AddProjectBloc, AddProjectState>(
        builder: (context, state) => MyTextField(
          text: TTexts.title,
          placeHolder: TTexts.labelTitle,
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onChange: (value) => context.read<AddProjectBloc>().add(TitleChangedAddProject(title: value)),
          errorMessage: state.title.displayError,
        ),
      );
}

class _DescriptionInput extends StatelessWidget {
  const _DescriptionInput();

  @override
  Widget build(BuildContext context) => BlocBuilder<AddProjectBloc, AddProjectState>(
        builder: (context, state) => MyTextField(
          maxLine: 5,
          text: TTexts.description,
          placeHolder: TTexts.labelDescription,
          textInputType: TextInputType.multiline,
          onChange: (value) => context.read<AddProjectBloc>().add(DescriptionChangedAddProject(description: value)),
          errorMessage: state.description.displayError,
        ),
      );
}

class _MyFloatingButton extends StatelessWidget {
  const _MyFloatingButton();

  @override
  Widget build(BuildContext context) => BlocBuilder<AddProjectBloc, AddProjectState>(
        builder: (context, state) => FloatingActionButton(
          onPressed: state.isValid ? () => Get.toNamed(AppRoutes.inviteFriends) : null,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            TIcons.arrowRight,
            color: !state.isValid ? TColors.base300 : null,
          ),
        ),
      );
}
