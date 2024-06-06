import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/domain/enums/status.dart';
import 'package:kyw_management/ui/widgets/my_card_status.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/icons.dart';

class DetailsTaskScreen extends StatelessWidget {
  const DetailsTaskScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Detalhes')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TConstants.defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Gap(10),

                  /// -- Data da criação
                  const Text(
                    '1 de nov de 2023 as 00:23',
                    style: TextStyle(color: TColors.base200),
                  ),

                  /// -- Detalhes
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: TColors.base200),
                      borderRadius: const BorderRadius.all(Radius.circular(TConstants.cardRadiusXs)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: _Card(
                            title: 'Admin',
                            info: 'Elon Musk ds s ',
                          ),
                        ),
                        Flexible(
                          child: _Card(
                            title: 'Projeto',
                            info: 'Projeto Integrado sd ssd sd s ds ds d drds',
                            isRight: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const Gap(20),

              /// Categoria
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Categoria',
                    style: TextStyle(fontSize: TConstants.fontSizeMd),
                  ),

                  /// -- Status
                  MyCardStatus(status: TaskStatus.incomplete)
                ],
              ),

              const Gap(20),

              /// Descrição
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Descrição',
                    style: TextStyle(
                      color: TColors.base200,
                      fontSize: TConstants.fontSizeMd,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 3, top: 5, right: 5),
                    child: Text(
                      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: TConstants.fontSizeMd + 1,
                      ),
                    ),
                  )
                ],
              ),

              const Gap(20),

              /// -- Membros
              const _Members(),
            ],
          ),
        ),
      );
}

class _Members extends StatefulWidget {
  const _Members();

  @override
  State<_Members> createState() => _MembersState();
}

class _MembersState extends State<_Members> {
  bool _isExpanded = false;

  void _changedExpansion(bool value) => setState(() => _isExpanded = value);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(TConstants.cardRadiusXs)),
        border: Border.all(color: TColors.borderSideColor),
      ),
      child: ExpansionTile(
        trailing: AnimatedRotation(
          turns: _isExpanded ? 0 : .5,
          duration: const Duration(milliseconds: 200),
          child: const Icon(
            TIcons.arrowTop,
            color: TColors.primary,
          ),
        ),
        backgroundColor: TColors.base200.withOpacity(.30),
        collapsedBackgroundColor: TColors.base200.withOpacity(.30),
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(TConstants.cardRadiusXs)),
          side: BorderSide(color: TColors.borderSideColor, width: 0),
        ),
        onExpansionChanged: _changedExpansion,
        title: const Text(
          'Membros',
          style: TextStyle(
            color: TColors.expansionTileTextColor,
            fontSize: TConstants.fontSizeMd,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: List.generate(
          2,
          (index) => Container(
            decoration: BoxDecoration(
              color: TColors.base100,
              borderRadius: BorderRadius.vertical(
                bottom: index == 1 ? const Radius.circular(TConstants.cardRadiusXs) : Radius.zero,
              ),
              border: Border(
                top: index == 1 ? BorderSide.none : const BorderSide(color: TColors.base200),
                bottom: index == 1 ? BorderSide.none : const BorderSide(color: TColors.base200),
              ),
            ),
            child: const ListTile(
              leading: Icon(TIcons.solidUser),
              title: Text('Kbuloso'),
            ),
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.title,
    required this.info,
    this.isRight = false,
  });

  final String title;
  final String info;
  final bool isRight;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: TColors.primary,
          border: Border(
            left: isRight ? const BorderSide(color: TColors.base200, width: .5) : BorderSide.none,
            right: isRight ? BorderSide.none : const BorderSide(color: TColors.base200, width: .5),
          ),
          borderRadius: BorderRadius.horizontal(
            left: isRight ? Radius.zero : const Radius.circular(TConstants.cardRadiusXs),
            right: isRight ? const Radius.circular(TConstants.cardRadiusXs) : Radius.zero,
          ),
        ),
        child: Column(
          children: <Widget>[
            _TitleChild(label: title),
            _InfoChild(
              info: info,
              isRight: isRight,
            ),
          ],
        ),
      );
}

class _TitleChild extends StatelessWidget {
  const _TitleChild({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Container(
        constraints: BoxConstraints(maxWidth: Get.width * .6),
        color: TColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Text(
          label,
          style: const TextStyle(
            color: TColors.base100,
            fontSize: TConstants.fontSizeLg,
          ),
        ),
      );
}

class _InfoChild extends StatelessWidget {
  const _InfoChild({required this.info, this.isRight = false});

  final String info;
  final bool isRight;

  @override
  Widget build(BuildContext context) => Container(
        constraints: BoxConstraints(maxWidth: Get.width * .6),
        decoration: BoxDecoration(
          color: TColors.base100,
          borderRadius: BorderRadius.only(
            bottomLeft: isRight ? Radius.zero : const Radius.circular(TConstants.cardRadiusXs),
            bottomRight: isRight ? const Radius.circular(TConstants.cardRadiusXs) : Radius.zero,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Text(
          info,
          style: const TextStyle(fontSize: TConstants.fontSizeLg),
        ),
      );
}
