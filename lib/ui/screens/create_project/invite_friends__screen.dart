import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/domain/models/project.dart';
import 'package:kyw_management/ui/state_management/blocs/add_project_bloc/add_project_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_bloc.dart';
import 'package:kyw_management/ui/widgets/create_project_screen.dart/my_text_field.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/icons.dart';
import 'package:kyw_management/utils/texts.dart';

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({super.key});

  @override
  State<InviteFriendsScreen> createState() => InviteFriendsScreenState();
}

class InviteFriendsScreenState extends State<InviteFriendsScreen> {
  late TextEditingController emailController;

  void setEmailController(value) => emailController.text = value;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text(TTexts.newProject)),
        body: BlocBuilder<AddProjectBloc, AddProjectState>(
          builder: (context, state) => Column(
            children: <Widget>[
              /// Convidar amigos
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                decoration: BoxDecoration(
                  color: TColors.base120,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: TColors.base900.withOpacity(.2),
                      blurRadius: 6,
                    )
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    /// -- Input do email
                    _EmailInput(),

                    /// -- Botão de convidar
                    _AddButton(),
                  ],
                ),
              ),

              /// Membros
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      /// -- Título membros
                      const _HeaderInvitedFriends(),

                      /// -- Lista com os membros convidados
                      Expanded(
                        flex: 11,
                        child: _ListMembers(users: state.invitedFriends.map((e) => e.value).toList()),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: const _MyFloatingButton(),
      );
}

class _HeaderInvitedFriends extends StatelessWidget {
  const _HeaderInvitedFriends();

  @override
  Widget build(BuildContext context) => const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              TTexts.guests,
              style: TextStyle(fontSize: TConstants.fontSizeLg),
            ),
          ),
          Divider(),
        ],
      );
}

class _MyFloatingButton extends StatelessWidget {
  const _MyFloatingButton();

  @override
  Widget build(BuildContext context) => BlocBuilder<AddProjectBloc, AddProjectState>(
        builder: (context, state) => FloatingActionButton(
          onPressed: state.isValid ? () => _completingAdditionProject(context, state) : null,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            TIcons.check,
            color: !state.isValid ? TColors.base300 : null,
          ),
        ),
      );

  void _completingAdditionProject(BuildContext context, AddProjectState state) {
    context.read<ProjectBloc>().add(
          AddProject(
            project: Project(
              id: Guid.newGuid.toString(),
              name: state.title.value,
            ),
          ),
        );
    context.read<AddProjectBloc>().add(FormSubmitteddAddProject());
    Get.offNamed(AppRoutes.home);
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) => BlocBuilder<AddProjectBloc, AddProjectState>(
        builder: (context, state) => MyTextField(
          controller: context.findAncestorStateOfType<InviteFriendsScreenState>()?.emailController,
          placeHolder: TTexts.labelEmail,
          text: TTexts.inviteFriendsByEmail,
          textInputType: TextInputType.emailAddress,
          onChange: (value) => context.read<AddProjectBloc>().add(EmailChangedAddProject(email: value)),
          errorMessage: state.email.displayError,
        ),
      );
}

class _AddButton extends StatelessWidget {
  const _AddButton();

  @override
  Widget build(BuildContext context) => BlocBuilder<AddProjectBloc, AddProjectState>(
        builder: (context, state) => TextButton(
          onPressed: () => {
            context.read<AddProjectBloc>().add(InvitedFriendsAddProject()),
            context.findAncestorStateOfType<InviteFriendsScreenState>()?.setEmailController(''),
          },
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(TConstants.cardRadiusXs))),
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 10)),
          ),
          child: const Chip(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(TConstants.cardRadiusXs)),
              side: BorderSide(color: Colors.transparent),
            ),
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                /// Ícone
                Icon(
                  TIcons.add,
                  color: TColors.base100,
                  size: TConstants.iconSm,
                ),
                Gap(5),

                /// Convidar
                Text(
                  TTexts.invite,
                  style: TextStyle(
                    fontSize: TConstants.fontSizeMd,
                    color: TColors.base100,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
      );
}

class _ListMembers extends StatelessWidget {
  const _ListMembers({required this.users});

  final List<String> users;

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: ((_, index) => ListTile(
              contentPadding: const EdgeInsets.only(left: 15),
              title: Text(
                users[index],
                style: const TextStyle(fontSize: TConstants.fontSizeLg),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: PopupMenuButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  TIcons.more,
                  color: TColors.primary,
                ),
                itemBuilder: (_) => [
                  PopupMenuItem(
                    child: const Row(
                      children: <Widget>[
                        Icon(
                          TIcons.remove,
                          size: TConstants.iconSm,
                          color: TColors.warn,
                        ),
                        Gap(5),
                        Text(
                          TTexts.remove,
                          style: TextStyle(color: TColors.warn),
                        ),
                      ],
                    ),
                    onTap: () => context.read<AddProjectBloc>().add(RemoveFriendsAddProject(email: users[index])),
                  ),
                ],
              ),
            )),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: users.length,
        padding: EdgeInsets.zero,
      );
}
