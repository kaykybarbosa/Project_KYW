import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/data/repositories/project_repository.dart';
import 'package:kyw_management/domain/enums/snack_bar_type.dart';
import 'package:kyw_management/ui/screens/project/widgets/my_text_field_border.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_bloc.dart';
import 'package:kyw_management/ui/state_management/cubits/add_member_project_cubit/add_member_project_cubit.dart';
import 'package:kyw_management/ui/widgets/imagens/my_image_network.dart';
import 'package:kyw_management/ui/widgets/submit_button.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/icons.dart';
import 'package:kyw_management/utils/snack_bar/snack_bar_custom.dart';

class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        return Scaffold(
            body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverPersistentDelegate(),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  /// Nome
                  _ProjectName(state.projectDetails.name),

                  /// Quantidade de membros
                  const _NumberOfMembers(),

                  const _Divider(),

                  /// Descrição
                  _Description(state.projectDetails.description),

                  const Gap(20),

                  /// Opções
                  const _Options(),

                  const _Divider(),

                  /// Membros
                  const _Members(),

                  const SizedBox(height: 10),
                ],
              ),
            )
          ],
        ));
      },
    );
  }
}

class _NumberOfMembers extends StatelessWidget {
  const _NumberOfMembers({this.style});

  final TextStyle? style;

  @override
  Widget build(BuildContext context) => BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) => Text(
          "${state.members.length > 1 ? 'Membros' : 'Membro'}: ${state.members.length}",
          style: style ??
              const TextStyle(
                color: TColors.base300,
              ),
        ),
      );
}

class _ProjectName extends StatelessWidget {
  const _ProjectName(this.name);

  final String name;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: TConstants.defaultMargin),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: TConstants.fontSizeLg + 4,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
}

class _Description extends StatelessWidget {
  const _Description(this.description);

  final String description;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: TConstants.fontSizeLg,
                  color: TColors.descriptions,
                ),
              ),
            ),
          ],
        ),
      );
}

class _Options extends StatefulWidget {
  const _Options();

  @override
  State<_Options> createState() => _OptionsState();
}

class _OptionsState extends State<_Options> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '');
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> options = [
      {
        'icon': TIcons.gallery,
        'title': 'Media',
        'onTap': () {},
      },
      {
        'icon': TIcons.userPlus,
        'title': 'Adicionar membros',
        'onTap': () => showModalBottomSheet(
              context: context,
              showDragHandle: true,
              isScrollControlled: true,
              builder: (context) => BlocProvider(
                create: (context) => AddMemberProjectCubit(IProjectRepository.instance),
                child: BlocBuilder<ProjectBloc, ProjectState>(
                  builder: (context, projecetState) {
                    return BlocConsumer<AddMemberProjectCubit, AddMemberProjectState>(
                      listener: (context, addMemberState) {
                        if (addMemberState.status.isSuccess) {
                          snackBarCustom(
                            showMessageText: false,
                            title: 'Membro adicionado com sucesso.',
                            type: SnackBarType.success,
                          );

                          _controller.text = '';

                          context.read<ProjectBloc>().add(GetMembers(projecetState.projectDetails.id));
                        } else if (addMemberState.status.isFailure) {
                          snackBarCustom(
                            showMessageText: false,
                            title: addMemberState.errorMessage ?? 'Não foi possível convidar o usuário.',
                            type: SnackBarType.failure,
                          );
                        }
                      },
                      builder: (context, state) {
                        return Container(
                          margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          padding: const EdgeInsets.symmetric(horizontal: TConstants.defaultMargin),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              /// Título
                              const Text(
                                'Adicionar membros',
                                style: TextStyle(
                                  fontSize: TConstants.fontSizeLg + 2,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Gap(10),

                              /// Input
                              MyTextFieldBorder(
                                controller: _controller,
                                text: 'E-mail',
                                placeHolder: 'E-mail do usuário',
                                errorText: state.email.displayError,
                                onChanged: (value) => context.read<AddMemberProjectCubit>().emailChanged(value),
                              ),
                              const Gap(25),

                              /// ConvidarBtn
                              SubmitButton(
                                label: 'Adicionar',
                                isInProgress: state.status.isInProgress,
                                onPressed: state.isValid
                                    ? () => context
                                        .read<AddMemberProjectCubit>()
                                        .submitForm(projecetState.projectDetails.id)
                                    : null,
                              ),
                              const Gap(10),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
      },
      {
        'icon': TIcons.link,
        'title': 'Convidar via link',
        'onTap': () {},
      },
    ];

    final lastOption = options.last;
    final border = BorderSide(color: Theme.of(context).dividerColor.withOpacity(.7));

    return Column(
      children: options
          .map(
            (option) => Container(
              decoration: BoxDecoration(
                border: Border(
                  top: border,
                  bottom: lastOption == option ? border : BorderSide.none,
                ),
              ),
              child: ListTile(
                leading: Icon(
                  option['icon'],
                  color: TColors.primary,
                ),
                title: Text(
                  option['title'],
                  style: const TextStyle(
                    fontSize: TConstants.fontSizeMd + 1,
                    color: TColors.descriptions,
                  ),
                ),
                trailing: const Icon(
                  TIcons.arrowRightIOS,
                  color: TColors.base300,
                ),
                onTap: option['onTap'],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _Members extends StatelessWidget {
  const _Members();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        final members = state.members;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// Título
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 5, bottom: 10),
              child: _NumberOfMembers(
                style: TextStyle(fontSize: TConstants.fontSizeLg - 1),
              ),
            ),

            /// Membros
            Column(
              children: members
                  .map<Widget>(
                    (member) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                      decoration: BoxDecoration(
                        color: TColors.base100,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: TColors.base900.withOpacity(.20),
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          /// Avatar
                          member.avatarUrlLocal != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    color: TColors.base150,
                                    child: Image.network(
                                      member.avatarUrlLocal!,
                                      width: 45,
                                      height: 45,
                                      cacheWidth: 157,
                                      cacheHeight: 157,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : const MyImageNetwork(
                                  cacheWidth: 157,
                                  cacheHeight: 157,
                                  assetsReplace: 'assets/user.png',
                                ),

                          const Gap(10),

                          /// Nome
                          Expanded(
                            child: Text(
                              member.isCurrentUser ? 'Você' : member.nickname,
                              style: const TextStyle(
                                fontSize: TConstants.fontSizeLg,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    final dividerColor = TColors.base150.withOpacity(.3);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(.1),
            blurRadius: 15,
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          Divider(color: dividerColor),
          const Gap(10),
          Divider(color: dividerColor),
        ],
      ),
    );
  }
}

class _SliverPersistentDelegate extends SliverPersistentHeaderDelegate {
  final maxHeaderHeight = 180.0;
  final minHeaderHeight = kToolbarHeight + 35.0;
  final maxImageSize = 130.0;
  final minImageSize = TConstants.imageCircular;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final topPositioned = MediaQuery.of(context).viewPadding.top + 5;
    final percent = shrinkOffset / (maxHeaderHeight - 80);
    final percent2 = shrinkOffset / (maxHeaderHeight - 35);
    final currentImageSize = (maxImageSize * (1 - percent)).clamp(
      minImageSize,
      maxImageSize,
    );
    final currentImagePositioned = ((Get.width / 2 - 65) * (1 - percent)).clamp(
      minImageSize,
      maxImageSize,
    );
    final iconColor = percent2 * 2 < 1 ? TColors.secondary : TColors.base100;

    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        final image = state.projectDetails.imageUrlLocal;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(statusBarIconBrightness: percent2 * 2 < 1 ? Brightness.dark : Brightness.light),
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Container(
              color: Theme.of(context).appBarTheme.backgroundColor!.withOpacity(percent2 * 2 < 1 ? percent2 * 2 : 1),
              child: Stack(
                children: <Widget>[
                  /// Nome do projeto
                  Positioned(
                    top: topPositioned + 15,
                    left: currentImagePositioned + 55,
                    child: SizedBox(
                      width: Get.width * .65,
                      child: Text(
                        state.projectDetails.name,
                        style: TextStyle(
                          fontSize: TConstants.fontSizeLg + 2,
                          color: TColors.base100.withOpacity(percent2 * 2 < 1 ? percent2 * 2 : 1),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  /// Voltar
                  Positioned(
                    left: 0,
                    top: topPositioned + 5,
                    child: BackButton(color: iconColor),
                  ),

                  /// Opções
                  Positioned(
                    right: 0,
                    top: topPositioned + 5,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        TIcons.more,
                        color: iconColor,
                      ),
                    ),
                  ),

                  /// Imagem
                  Positioned(
                    left: currentImagePositioned,
                    top: topPositioned,
                    bottom: 0,
                    child: Hero(
                      tag: 'details_project',
                      child: MyImageNetwork(
                        image: image,
                        assetsReplace: 'assets/group.png',
                        width: currentImageSize,
                        cacheWidth: 157,
                        cacheHeight: 217,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  double get maxExtent => maxHeaderHeight;

  @override
  double get minExtent => minHeaderHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
