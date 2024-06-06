import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/ui/screens/project/widgets/my_text_field_border.dart';
import 'package:kyw_management/ui/state_management/blocs/add_project_bloc/add_project_bloc.dart';
import 'package:kyw_management/ui/widgets/circle_image.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/icons.dart';
import 'package:kyw_management/utils/texts.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => CreateProjectScreenState();
}

class CreateProjectScreenState extends State<CreateProjectScreen> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();

    pageController.dispose();
  }

  void changePage() {
    int page = 0;

    if (pageController.page?.toInt() == 0) {
      page = 1;
    }

    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AddProjectBloc(),
        child: BlocBuilder<AddProjectBloc, AddProjectState>(
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  if (pageController.page?.toInt() == 1) {
                    context.read<AddProjectBloc>().add(ChangedCurrentPage());
                    changePage();
                  } else {
                    Get.back();
                  }
                },
              ),
              title: const Text('Novo Projeto'),
            ),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: const [
                /// Título e Descrição
                _NameAndDescriptionScreen(),

                /// Convidar amigos
                InviteFriendsScreen(),
              ],
            ),
            floatingActionButton: const _MyFloatingButton(),
          ),
        ),
      );
}

class _NameAndDescriptionScreen extends StatelessWidget {
  const _NameAndDescriptionScreen();

  @override
  Widget build(BuildContext context) => const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: TConstants.defaultMargin),
          child: Column(
            children: <Widget>[
              Gap(10),

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
      );
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
        builder: (context, state) => MyTextFieldBorder(
          text: TTexts.title,
          initialValue: state.title.value,
          placeHolder: TTexts.labelTitle,
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onChange: (value) => context.read<AddProjectBloc>().add(TitleChanged(title: value)),
          errorText: state.title.displayError,
        ),
      );
}

class _DescriptionInput extends StatelessWidget {
  const _DescriptionInput();

  @override
  Widget build(BuildContext context) => BlocBuilder<AddProjectBloc, AddProjectState>(
        builder: (context, state) => MyTextFieldBorder(
          maxLine: 5,
          initialValue: state.description.value,
          text: TTexts.description,
          placeHolder: TTexts.labelDescription,
          textInputType: TextInputType.multiline,
          onChange: (value) => context.read<AddProjectBloc>().add(DescriptionChanged(description: value)),
          errorText: state.description.displayError,
        ),
      );
}

class _MyFloatingButton extends StatelessWidget {
  const _MyFloatingButton();

  @override
  Widget build(BuildContext context) {
    void changePage(int currentPage) {
      if (currentPage == 0) {
        context.read<AddProjectBloc>().add(ChangedCurrentPage());
        context.findAncestorStateOfType<CreateProjectScreenState>()?.changePage();
      } else {
        context.read<AddProjectBloc>().add(FormSubmittedd());
      }
    }

    return BlocBuilder<AddProjectBloc, AddProjectState>(
      builder: (context, state) => FloatingActionButton(
        onPressed: state.isValid ? () => changePage(state.currentPage) : null,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          state.currentPage == 0 ? TIcons.arrowRight : TIcons.check,
          color: !state.isValid ? TColors.base300 : null,
        ),
      ),
    );
  }
}
