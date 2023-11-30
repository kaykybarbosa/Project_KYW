import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar(
      {super.key, required this.placeHolder, this.search, this.controller});

  final String placeHolder;
  final Function? search;
  final TextEditingController? controller;

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Input for search
        Expanded(
          child: SearchBar(
            backgroundColor: null,
            hintText: 'Buscar ${widget.placeHolder}',
            side: const MaterialStatePropertyAll(
                BorderSide(color: CupertinoColors.systemGrey)),
            elevation: const MaterialStatePropertyAll(0),
            constraints: const BoxConstraints(
                minWidth: 50.0, maxWidth: 600.0, minHeight: 40.0),
            hintStyle: const MaterialStatePropertyAll(
                TextStyle(color: CupertinoColors.placeholderText)),
            textStyle: MaterialStatePropertyAll(
                TextStyle(color: CupertinoTheme.of(context).primaryColor)),
          ),
        ),

        // Icon search
        Container(
          margin: const EdgeInsets.only(left: 10.0),
          height: 40.0,
          width: 40.0,
          decoration: BoxDecoration(
            color: CupertinoColors.systemBlue,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: IconButton(
            onPressed: () {
              widget.search;
            },
            icon: const Icon(
              CupertinoIcons.search,
              size: 23.0,
              color: CupertinoColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
