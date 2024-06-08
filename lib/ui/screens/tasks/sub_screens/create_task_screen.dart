import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/ui/screens/project/widgets/my_text_field_border.dart';
import 'package:kyw_management/ui/widgets/expansion_tile/my_expansion_child.dart';
import 'package:kyw_management/ui/widgets/expansion_tile/my_expansion_tile.dart';
import 'package:kyw_management/ui/widgets/expansion_tile/my_expansion_title.dart';
import 'package:kyw_management/ui/widgets/my_icon_drag.dart';
import 'package:kyw_management/ui/widgets/submit_button.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/icons.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar task')),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: TConstants.defaultMargin),
        child: Column(
          children: <Widget>[
            /// -- Campos
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Gap(10),

                    /// Título
                    _Title(),

                    /// Categoria
                    _Category(),

                    Gap(10),

                    /// Data de conclusão
                    _DateOfConclusion(),

                    Gap(20),

                    /// Selecionar membros
                    _SelectMembers(),

                    Gap(40),

                    /// Descrição
                    _Description(),

                    Gap(10),
                  ],
                ),
              ),
            ),

            /// -- Criar task btn
            _SubmitBtn(),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) => const MyTextFieldBorder(
        text: 'Título',
        placeHolder: 'Insira o título',
      );
}

class _Category extends StatelessWidget {
  const _Category();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'label': 'Categoria 1',
        'trailing': null,
        'style': null,
        'onTap': () {},
      },
      {
        'label': 'Categoria 2',
        'trailing': null,
        'style': null,
        'onTap': () {},
      },
      {
        'label': 'Adicionar categoria',
        'trailing': const Icon(
          TIcons.add,
          color: TColors.primary,
        ),
        'style': const TextStyle(
          color: TColors.primary,
          fontWeight: FontWeight.bold,
        ),
        'onTap': () {},
      }
    ];

    return MyExpansionTile.border(
      title: 'Categoria',
      placeHolder: MyExpansionTitle(
        'Selecione uma categoria',
        style: Theme.of(context).inputDecorationTheme.hintStyle,
      ),
      children: categories.map((category) {
        final isFirst = categories.first == category;
        final isLast = categories.last == category;

        return MyExpansionChild(
          isFirst: isFirst,
          isLast: isLast,
          child: ListTile(
            title: Text(
              category['label'],
              style: category['style'],
            ),
            trailing: category['trailing'],
            onTap: category['onTap'],
          ),
        );
      }).toList(),
    );
  }
}

class _DateOfConclusion extends StatelessWidget {
  const _DateOfConclusion();

  @override
  Widget build(BuildContext context) => const MyTextFieldBorder(
        text: 'Data de conclusão',
        placeHolder: 'xx/xx/xxxx',
        suffix: Icon(
          TIcons.calendar,
          size: TConstants.iconMd - 2,
        ),
      );
}

class _SelectMembers extends StatelessWidget {
  const _SelectMembers();

  @override
  Widget build(BuildContext context) => const MyExpansionTile.border(
        showBorder: false,
        borderColor: TColors.base100,
        backgroundColor: TColors.primary,
        icon: Icon(
          TIcons.arrowUpIOS,
          color: TColors.base100,
        ),
        placeHolder: Text(
          'Selecionar membros',
          style: TextStyle(
            color: TColors.base100,
          ),
        ),
      );
}

class _Description extends StatefulWidget {
  const _Description();

  @override
  State<_Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<_Description> {
  final valueMax = 10;
  final valueMin = 3;
  int maxLines = 3;
  final border = const BorderSide(color: TColors.base150);

  final List<Map<String, dynamic>> icons = [
    {'icon': TIcons.bold, 'onTap': () {}},
    {'icon': TIcons.italic, 'onTap': () {}},
    {'icon': TIcons.attachment, 'onTap': () {}}
  ];

  void _setHeightInput(double? value) {
    setState(() {
      if (value != null) {
        if (value > 0 && maxLines != valueMax) {
          maxLines += 1;
        } else if (value < 0 && maxLines != valueMin) {
          maxLines -= 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        /// Ícones
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: TColors.base150),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(TConstants.cardRadiusXs)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: TConstants.defaultMargin,
            ),
            child: Row(
              children: icons
                  .map(
                    (icon) => IconButton(
                      icon: Icon(
                        icon['icon'],
                        color: TColors.base900,
                      ),
                      onPressed: icon['onTap'],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),

        /// Descrição
        Container(
          decoration: BoxDecoration(
            border: Border(left: border, right: border, bottom: border),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(TConstants.cardRadiusXs)),
          ),
          child: TextFormField(
            maxLines: maxLines,
            decoration: const InputDecoration(
              hintText: 'Descrição',
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),

        /// Ícone
        MyIconDrag(
          isDrag: maxLines == valueMax,
          onVerticalDragUpdate: _setHeightInput,
        ),
      ],
    );
  }
}

class _SubmitBtn extends StatelessWidget {
  const _SubmitBtn();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SubmitButton(
          label: 'Criar task',
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: TColors.success,
          ),
        ),
      );
}
