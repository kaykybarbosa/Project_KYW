import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kyw_management/app/models/project.dart';

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
  final Color primaryColor = const Color.fromRGBO(50, 58, 71, 1);

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
          color: primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: CupertinoColors.systemGrey4),
            borderRadius: const BorderRadius.only(
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
              _NameGroup(widget: widget, primaryColor: primaryColor),
              _MySufix(widget: widget)
            ],
          ),
        ),
      ),
    );
  }
}

class _NameGroup extends StatelessWidget {
  const _NameGroup({
    required this.widget,
    required this.primaryColor,
  });

  final CardProject widget;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Group name
            Text(
              widget.project.name,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            // Last message send
            Text(
              widget.project.lastMessage ?? 'Você criou este projeto',
              style: const TextStyle(
                fontSize: 16,
                color: CupertinoColors.systemGrey2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MySufix extends StatelessWidget {
  const _MySufix({required this.widget});

  final CardProject widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          // Last message time
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
            children: [
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
