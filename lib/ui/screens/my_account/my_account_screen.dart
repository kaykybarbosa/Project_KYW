import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/data/storages/models/current_user_model.dart';
import 'package:kyw_management/ui/widgets/expansion_tile/avatar_url_tile.dart';
import 'package:kyw_management/ui/widgets/my_text_field.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/icons.dart';
import 'package:kyw_management/utils/input_formatters.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  late final CurrentUserModel _currentUser;

  void _changeData(context, {required Widget input, String title = 'Insira seu nome'}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: TConstants.defaultMargin + 4, vertical: 10),
        margin: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Gap(10),

            /// Título
            Text(
              title,
              style: const TextStyle(
                fontSize: TConstants.fontSizeLg,
              ),
            ),

            /// Input
            input,
            const Gap(10),

            /// Cancelar/Salvar
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {},
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _currentUser = AppController.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> options = [
      {
        'title': 'Nome',
        'label': _currentUser.nickname,
        'icon': TIcons.solidUser,
        'onTap': () => _changeData(context, input: const _NameInput()),
      },
      {
        'title': 'E-mail',
        'label': _currentUser.email,
        'icon': TIcons.email,
        'onTap': () => _changeData(
              context,
              title: 'Insira seu e-mail',
              input: const _EmailInput(),
            ),
      },
      {
        'title': 'Telefone',
        'label': InputFormatters.phone.maskText(_currentUser.phone),
        'icon': TIcons.phone,
        'onTap': () => _changeData(
              context,
              title: 'Insira seu telefone',
              input: const _PhoneInput(),
            ),
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Minha Conta')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Gap(20.0),

          /// Avatar
          _ProfileImage(_currentUser.avatarUrlLocal),
          const Gap(20.0),

          // Informations the user
          Expanded(
            child: ListView.separated(
              itemCount: options.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => ListTile(
                leading: Icon(
                  options[index]['icon'],
                  color: TColors.base200,
                  size: TConstants.iconMd - 4,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /// Título
                    Text(
                      options[index]['title'],
                      style: const TextStyle(
                        fontSize: TConstants.fontSizeSm - 1,
                        color: TColors.base200,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const Gap(3),

                    /// Valor
                    Text(
                      options[index]['label'],
                      style: const TextStyle(
                        fontSize: TConstants.fontSizeLg - 1,
                        fontWeight: FontWeight.w500,
                        color: TColors.secondary,
                      ),
                    ),
                  ],
                ),
                trailing: const _ChangeDataIcon(),
                onTap: () => options[index]['onTap'](),
              ),
              separatorBuilder: (__, _) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Divider(height: 0.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: 3),
      child: MyTextFormField(
        hintText: '',
        isInputUnderline: true,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: 3),
      child: MyTextFormField(
        hintText: '',
        isInputUnderline: true,
        contentPadding: EdgeInsets.zero,
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}

class _PhoneInput extends StatelessWidget {
  const _PhoneInput();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 3),
        child: MyTextFormField(
          hintText: '',
          isInputUnderline: true,
          contentPadding: EdgeInsets.zero,
          inputFormatters: [InputFormatters.phone],
          keyboardType: TextInputType.number,
        ),
      );
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage(this.avatarUrlLocal);

  final String? avatarUrlLocal;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: const Alignment(.95, .6),
        children: <Widget>[
          AvatarUrlTile(
            avatarUrl: avatarUrlLocal,
            width: 130,
            cacheWidth: 455,
            cacheHeight: 455,
          ),
          InkWell(
            onTap: () {},
            child: const _ChangeDataIcon(),
          ),
        ],
      );
}

class _ChangeDataIcon extends StatelessWidget {
  const _ChangeDataIcon();

  @override
  Widget build(BuildContext context) => Stack(
        alignment: const Alignment(2.4, -2.4),
        children: <Widget>[
          Container(
            width: 18.0,
            height: 18.0,
            padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
            decoration: BoxDecoration(
              color: TColors.base100,
              border: Border.all(color: TColors.base200),
              borderRadius: BorderRadius.circular(TConstants.cardRadiusXs - 7),
            ),
            child: const SizedBox(),
          ),
          const Icon(
            TIcons.pen,
            size: TConstants.iconXs + 2,
            color: TColors.primary,
          ),
        ],
      );
}
