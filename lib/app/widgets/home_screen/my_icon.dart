import 'package:flutter/material.dart';
import 'package:kyw_management/domain/blocs/blocs_export.dart';

class MyIcon extends StatelessWidget {
  const MyIcon({
    super.key,
    required this.icon,
    required this.onTap,
    this.showBadge = true,
  });

  final IconData icon;
  final Function onTap;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () => onTap(),
          icon: Badge(
            label:
                showBadge ? (state.haveMessage ? const Text('2') : null) : null,
            smallSize: showBadge ? (state.haveMessage ? 6 : 0) : 0,
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 22,
            ),
          ),
        );
      },
    );
  }
}
