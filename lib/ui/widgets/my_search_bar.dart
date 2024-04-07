import 'package:flutter/material.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({
    super.key,
    required this.onPressed,
    this.hintText,
  });

  final void Function()? onPressed;
  final String? hintText;

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          // Input de busca
          Expanded(
            child: SearchBar(
              hintText: widget.hintText,
              constraints: const BoxConstraints(minHeight: 40.0),
            ),
          ),

          // Ícone
          Container(
            margin: const EdgeInsets.only(left: 10),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: TColors.primary,
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              onPressed: widget.onPressed,
              icon: const Icon(
                Icons.search,
                size: TConstants.iconMd,
                color: TColors.base100,
              ),
            ),
          ),
        ],
      );
}
