import 'package:flutter/widgets.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.padding,
    this.iconSize = 110,
    this.fontSize = 45,
    this.isDarkMode = false,
  });

  final EdgeInsetsGeometry? padding;
  final double iconSize;
  final double fontSize;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo.png',
      fit: BoxFit.cover,
      width: 100,
    );
  }

  // @override
  // Widget build(BuildContext context) => Center(
  //       child: Stack(
  //         alignment: Alignment.center,
  //         children: <Widget>[
  //           Padding(
  //             padding: padding ?? const EdgeInsets.only(top: 27.0),
  //             child: Icon(
  //               TIcons.logo,
  //               color: isDarkMode ? TColors.base100.withOpacity(.4) : TColors.secondary.withOpacity(.5),
  //               size: iconSize,
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 12),
  //             child: Text(
  //               'K Y W',
  //               style: GoogleFonts.roboto(
  //                 fontSize: fontSize,
  //                 color: isDarkMode ? TColors.base100 : TColors.secondary,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
}
