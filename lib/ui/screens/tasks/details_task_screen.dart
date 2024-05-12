import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/domain/enums/status.dart';
import 'package:kyw_management/ui/widgets/my_card_status.dart';
import 'package:kyw_management/utils/colors.dart';

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
              /// Data da criação
              const Text(
                '1 de nov de 2023 as 00:23',
                style: TextStyle(color: TColors.base200),
              ),

              const Gap(20),

              /// Detalhes
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Card(title: 'Admin', info: 'Elon Musk'),
                  _Card(
                    title: 'Projeto',
                    info: 'Projeto Integrador',
                    isRight: true,
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
                children: [
                  Text(
                    'Descrição',
                    style: TextStyle(color: TColors.base200),
                  ),
                  Text(
                    'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English.',
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ],
          ),
        ),
      );
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
          border: Border.all(color: TColors.base200, width: .5),
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
