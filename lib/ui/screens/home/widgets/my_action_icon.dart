import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/home_bloc/home_bloc.dart';
import 'package:kyw_management/utils/constants.dart';

class MyActionIcon extends StatelessWidget {
  const MyActionIcon({
    super.key,
    required this.icon,
    required this.onTap,
    this.showBadge = true,
  });

  final IconData icon;
  final void Function()? onTap;
  final bool showBadge;

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) => IconButton(
          onPressed: onTap,
          icon: Badge(
            label: showBadge ? (state.haveMessage ? const Text('2') : null) : null,
            smallSize: showBadge ? (state.haveMessage ? 6 : 0) : 0,
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.onPrimary,
              size: Constants.mediumIcon,
            ),
          ),
        ),
      );
}
