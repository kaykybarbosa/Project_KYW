import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kyw_management/domain/models/project.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

class CardProject extends StatefulWidget {
  const CardProject({
    super.key,
    required this.project,
    required this.onTap,
  });

  final Project project;
  final Function onTap;

  @override
  State<CardProject> createState() => _CardProjectState();
}

class _CardProjectState extends State<CardProject> {
  Widget _getImage() {
    if (widget.project.image != null) {
      return Image.asset(
        widget.project.image!,
        width: 52,
      );
    } else {
      return Container(
        color: Colors.grey,
        padding: const EdgeInsets.all(12),
        child: Icon(
          Icons.group,
          size: 27,
          color: Colors.grey[200],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(),
      child: Container(
        padding: const EdgeInsets.only(left: 6),
        margin: const EdgeInsets.symmetric(vertical: 2.5),
        decoration: BoxDecoration(
          color: TColors.secondary,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey),
              right: BorderSide(color: Colors.grey),
              bottom: BorderSide(color: Colors.grey),
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Group image
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: _getImage(),
              ),

              /// Nome do grupo
              _GroupName(project: widget.project),

              /// Está fixado
              _MySufix(widget: widget)
            ],
          ),
        ),
      ),
    );
  }
}

class _GroupName extends StatelessWidget {
  const _GroupName({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: <Widget>[
            Column(
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
                Text(
                  project.lastMessage ?? 'Você criou este projeto',
                  style: const TextStyle(
                    fontSize: TConstants.fontSizeMd,
                    color: TColors.base200,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}

class _MySufix extends StatelessWidget {
  const _MySufix({required this.widget});

  final CardProject widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          // Last message time
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                widget.project.lastMessageTime ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // IsImportant
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                widget.project.isImportant ? FontAwesomeIcons.thumbtack : null,
                color: CupertinoColors.systemGrey2,
                size: 21.5,
              )
            ],
          )
        ],
      ),
    );
  }
}
