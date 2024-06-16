import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/domain/enums/snack_bar_type.dart';
import 'package:kyw_management/ui/screens/project/widgets/my_text_field_border.dart';
import 'package:kyw_management/ui/state_management/cubits/create_project_cubit/create_project_cubit.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/icons.dart';
import 'package:kyw_management/utils/snack_bar/snack_bar_custom.dart';
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
  Widget build(BuildContext context) => BlocConsumer<CreateProjectCubit, CreateProjectState>(
        // listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status.isEmailAlreadyExists) {
            snackbarCustom(
              title: 'Este e-mail já está na lista de Membros.',
              showMessageText: false,
              type: SnackBarType.failure,
            );
          }

          if (state.status.isEmailAdded) {
            setEmailController('');
          }
        },
        builder: (_, state) => const _InviteFriendsScreen(),
      );
}

class _InviteFriendsScreen extends StatelessWidget {
  const _InviteFriendsScreen();

  @override
  Widget build(BuildContext context) => BlocBuilder<CreateProjectCubit, CreateProjectState>(
        buildWhen: (previous, current) => current.currentPage == 1,
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
                      child: _ListMembers(users: state.invitedMembers.map((e) => e.value).toList()),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
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

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) => BlocBuilder<CreateProjectCubit, CreateProjectState>(
        builder: (context, state) => MyTextFieldBorder(
          controller: context.findAncestorStateOfType<InviteFriendsScreenState>()?.emailController,
          placeHolder: TTexts.labelEmail,
          text: TTexts.inviteFriendsByEmail,
          textInputType: TextInputType.emailAddress,
          onChanged: (value) => context.read<CreateProjectCubit>().emailChanged(value),
          errorText: state.email.displayError,
        ),
      );
}

class _AddButton extends StatelessWidget {
  const _AddButton();

  @override
  Widget build(BuildContext context) => BlocBuilder<CreateProjectCubit, CreateProjectState>(
        builder: (context, state) => TextButton(
          onPressed: () => context.read<CreateProjectCubit>().invitedMembers(),
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(TConstants.cardRadiusXs))),
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 10)),
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
                itemBuilder: (_) => <PopupMenuEntry<dynamic>>[
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
                    onTap: () => context.read<CreateProjectCubit>().removeMember(users[index]),
                  ),
                ],
              ),
            )),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: users.length,
        padding: EdgeInsets.zero,
      );
}
