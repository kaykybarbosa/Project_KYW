import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/data/dtos/response/all_projects_response.dart';
import 'package:kyw_management/env/env.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/icons.dart';

class CardProject extends StatelessWidget {
  const CardProject({
    super.key,
    required this.project,
    this.onTap,
  });

  final ProjectResponse project;
  final Function()? onTap;

  Widget _getImage() {
    const imageCircular = TConstants.imageCircular;

    if (project.imageUrl != null) {
      final image = project.imageUrl!.replaceAll(
        RegExp(r'localhost'),
        Env.LOCALHOST,
      );

      return Container(
        color: TColors.base120,
        width: imageCircular,
        height: imageCircular,
        child: Image.network(
          image,
          width: imageCircular,
          height: imageCircular,
          cacheWidth: 123,
          cacheHeight: 123,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Image.asset(
        'assets/group.png',
        width: imageCircular,
        height: imageCircular,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = true;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(TConstants.cardRadiusXs),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2.5),
        decoration: BoxDecoration(
          border: const Border(
            left: BorderSide(
              color: TColors.secondary,
              width: 6,
            ),
          ),
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
                topLeft: Radius.circular(TConstants.radiusLeftInput),
                bottomLeft: Radius.circular(TConstants.radiusLeftInput),
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
}

class _GroupName extends StatelessWidget {
  const _GroupName({required this.project});

  final ProjectResponse project;

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
                fontSize: TConstants.fontSizeLg - 1,
                fontWeight: FontWeight.bold,
                color: TColors.secondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            // Última mensagem enviada
            const Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Você criou este projeto',
                    style: TextStyle(
                      fontSize: TConstants.fontSizeMd - 1,
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

  final ProjectResponse project;

  @override
  Widget build(BuildContext context) => const Expanded(
        child: Column(
          children: <Widget>[
            /// Horário da última mensagem
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  '',
                  style: TextStyle(
                    fontSize: TConstants.fontSizeSm,
                    color: TColors.base200,
                  ),
                ),
              ],
            ),

            Gap(6),

            // Está fixado
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  TIcons.isImportant,
                  color: TColors.base200,
                  size: TConstants.iconSm + 3,
                )
              ],
            )
          ],
        ),
      );
}
