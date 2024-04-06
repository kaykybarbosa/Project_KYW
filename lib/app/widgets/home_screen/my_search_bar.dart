import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/domain/blocs/home_bloc/home_bloc.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key, required this.search, String? hintText}) : _hintText = hintText;

  final Function search;
  final String? _hintText;

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Row(
          children: [
            // Input for search
            Expanded(child: SearchBar(hintText: widget._hintText ?? 'Buscar ${state.currentScreen.name}')),

            // Icon search
            Container(
              margin: const EdgeInsets.only(left: 10),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                onPressed: () => widget.search(),
                icon: const Icon(
                  Icons.search,
                  size: 23,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
