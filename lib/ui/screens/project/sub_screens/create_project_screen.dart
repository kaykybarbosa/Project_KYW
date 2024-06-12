import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/data/repositories/project_repository.dart';
import 'package:kyw_management/domain/enums/snack_bar_type.dart';
import 'package:kyw_management/ui/screens/project/widgets/my_text_field_border.dart';
import 'package:kyw_management/ui/state_management/blocs/add_project_bloc/add_project_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_bloc.dart';
import 'package:kyw_management/ui/widgets/circle_image.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/icons.dart';
import 'package:kyw_management/utils/snack_bar/snack_bar_custom.dart';
import 'package:kyw_management/utils/texts.dart';

class CreateProjectScreen extends StatelessWidget {
  const CreateProjectScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AddProjectBloc(IProjectRepository.instance),
        child: BlocConsumer<AddProjectBloc, AddProjectState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isSuccess) {
              context.read<ProjectBloc>().add(const GetAllProjects(canGetAll: true));

              snackBarCustom(
                title: 'Sucesso.',
                message: 'Projeto criado.',
              );

              Get.offAndToNamed(AppRoutes.home);
            } else if (state.status.isFailure) {
              snackBarCustom(
                message: state.errorMessage ?? 'Erro ao criar projeto.',
                type: SnackBarType.failure,
              );
            }
          },
          builder: (context, state) => _Body(),
        ),
      );
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
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
  Widget build(BuildContext context) {
    return Scaffold(
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
          /// Imagem, Título e Descrição
          _NameAndDescriptionScreen(),

          /// Convidar amigos
          InviteFriendsScreen(),
        ],
      ),
      floatingActionButton: const _MyFloatingButton(),
    );
  }
}

class _NameAndDescriptionScreen extends StatelessWidget {
  const _NameAndDescriptionScreen();

  @override
  Widget build(BuildContext context) => const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: TConstants.defaultMargin),
          child: Column(
            children: <Widget>[
              /// Título
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: _SelectImagemTitle(),
              ),

              /// Imagem do grupo
              _Image(),
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

class _Image extends StatelessWidget {
  const _Image();

  @override
  Widget build(BuildContext context) => BlocConsumer<AddProjectBloc, AddProjectState>(
        buildWhen: (previous, current) => previous.image != current.image,
        listener: (context, state) {
          if (state.status.isPickerImageFailure) {
            snackBarCustom(title: 'Erro ao selecionar image..', type: SnackBarType.failure);
          } else if (state.status.isPickerImageSuccess) {
            snackBarCustom(title: 'Imagem selecionada.');
          }
        },
        builder: (context, state) => CircleImage(
          image: state.image,
          onTap: () => showModalBottomSheet(
            context: context,
            showDragHandle: true,
            builder: (_) => Padding(
              padding: const EdgeInsets.only(
                left: TConstants.defaultMargin,
                right: TConstants.defaultMargin,
                bottom: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  /// Título
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      /// -- label
                      const Text(
                        'Imagem do projeto',
                        style: TextStyle(fontSize: TConstants.fontSizeLg + 1),
                      ),

                      /// -- ícone
                      Visibility(
                        visible: state.image != null,
                        child: IconButton(
                          onPressed: () => {
                            Get.back(),
                            context.read<AddProjectBloc>().add(RemoveImage()),
                          },
                          constraints: const BoxConstraints(maxHeight: 20, maxWidth: 20),
                          icon: const Icon(
                            TIcons.trash,
                            color: TColors.secondary,
                            size: TConstants.iconSm + 1,
                          ),
                        ),
                      )
                    ],
                  ),

                  const Gap(15),

                  /// Opções
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      PickerIcon(
                        label: 'Câmera',
                        icon: TIcons.camera,
                        onTap: () => {
                          Get.back(),
                          context.read<AddProjectBloc>().add(const PickerImage()),
                        },
                      ),
                      PickerIcon(
                        label: 'Galeria',
                        icon: TIcons.gallery,
                        onTap: () => {
                          Get.back(),
                          context.read<AddProjectBloc>().add(const PickerImage(fromGallery: true)),
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
        buildWhen: (previous, current) => previous.title.value != current.title.value,
        builder: (context, state) => MyTextFieldBorder(
          text: TTexts.title,
          initialValue: state.title.value,
          placeHolder: TTexts.labelTitle,
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onChanged: (value) => context.read<AddProjectBloc>().add(TitleChanged(title: value)),
          errorText: state.title.displayError,
        ),
      );
}

class _DescriptionInput extends StatelessWidget {
  const _DescriptionInput();

  @override
  Widget build(BuildContext context) => BlocBuilder<AddProjectBloc, AddProjectState>(
        buildWhen: (previous, current) => previous.description.value != current.description.value,
        builder: (context, state) => MyTextFieldBorder(
          maxLine: 5,
          initialValue: state.description.value,
          text: TTexts.description,
          placeHolder: TTexts.labelDescription,
          textInputType: TextInputType.multiline,
          onChanged: (value) => context.read<AddProjectBloc>().add(DescriptionChanged(description: value)),
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
        context.findAncestorStateOfType<_BodyState>()?.changePage();
      } else {
        context.read<AddProjectBloc>().add(FormSubmittedd());
      }
    }

    return BlocBuilder<AddProjectBloc, AddProjectState>(
      buildWhen: (previous, current) =>
          previous.isValid != current.isValid || previous.currentPage != current.currentPage,
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

class PickerIcon extends StatelessWidget {
  const PickerIcon({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final Function()? onTap;

  BoxDecoration _buildDecoration(context) => BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: TColors.base150.withOpacity(.5),
      );

  Icon _buildIcon(context) {
    return Icon(
      icon,
      size: TConstants.iconMd,
      color: TColors.base300,
    );
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: _buildDecoration(context),
              child: _buildIcon(context),
            ),
          ),
          const Gap(10),
          Text(label),
        ],
      );
}
