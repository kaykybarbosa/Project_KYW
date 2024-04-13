import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/domain/models/project.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/icons.dart';

class CardProject extends StatelessWidget {
  const CardProject({
    super.key,
    required this.project,
    this.onTap,
  });

  final Project project;
  final Function()? onTap;

  Widget _getImage() {
    if (project.image != null) {
      return Image.asset(
        project.image!,
        width: 52,
      );
    } else {
      return Container(
        color: TColors.base200,
        padding: const EdgeInsets.all(12),
        child: const Icon(
          Icons.group,
          size: 27,
          color: TColors.base100,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(left: 6),
          margin: const EdgeInsets.symmetric(vertical: 2.5),
          decoration: BoxDecoration(
            color: TColors.secondary,
            borderRadius: BorderRadius.circular(TConstants.cardRadiusXs),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            decoration: BoxDecoration(
                color: TColors.base100,
                border: const Border(
                  top: BorderSide(color: TColors.base200),
                  right: BorderSide(color: TColors.base200),
                  bottom: BorderSide(color: TColors.base200),
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(TConstants.cardRadiusXs),
                  bottomRight: Radius.circular(TConstants.cardRadiusXs),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: TColors.base900.withOpacity(.16),
                    blurRadius: TConstants.blurRadius,
                  )
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// Imagem do grupo
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: _getImage(),
                ),

                /// Nome do grupo
                Expanded(
                  flex: 5,
                  child: _GroupName(project: project),
                ),

                /// Está fixado
                _MySufix(project: project)
              ],
            ),
          ),
        ),
      );
}

class _GroupName extends StatelessWidget {
  const _GroupName({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// Nome do grupo
            Text(
              project.name,
              style: const TextStyle(
                fontSize: TConstants.fontSizeLg,
                fontWeight: FontWeight.bold,
                color: TColors.secondary,
              ),
            ),

            // Última mensagem enviada
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    project.lastMessage ?? 'Você criou este projeto',
                    style: const TextStyle(
                      fontSize: TConstants.fontSizeMd,
                      color: TColors.base200,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}

class _MySufix extends StatelessWidget {
  const _MySufix({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          children: <Widget>[
            /// Horário da última mensagem
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  project.lastMessageTime ?? '',
                  style: const TextStyle(
                    fontSize: TConstants.fontSizeSm,
                    color: TColors.base200,
                  ),
                ),
              ],
            ),

            const Gap(6),

            // Está fixado
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  project.isImportant ? TIcons.isImportant : null,
                  color: TColors.base200,
                  size: TConstants.iconSm + 3,
                )
              ],
            )
          ],
        ),
      );
}
