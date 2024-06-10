import 'package:flutter/widgets.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.padding,
    this.width = 100,
    this.height = 100,
    this.isDarkMode = false,
  });

  final EdgeInsetsGeometry? padding;
  final bool isDarkMode;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final image = isDarkMode ? 'logo_dark.png' : 'logo.png';

    return Center(
      child: Image.asset(
        'assets/$image',
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
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
