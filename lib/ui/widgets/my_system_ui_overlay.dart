import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MySystemUiOverlay extends StatelessWidget {
  const MySystemUiOverlay({
    super.key,
    required this.child,
    this.isDarkMode = false,
  });

  final Widget child;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: Theme.of(context).appBarTheme.systemOverlayStyle!.copyWith(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
            ),
        child: child,
      );
}
