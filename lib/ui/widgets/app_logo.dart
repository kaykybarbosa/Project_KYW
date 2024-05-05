import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/icons.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.padding,
    this.size,
    this.isDarkMode = false,
  });

  final EdgeInsetsGeometry? padding;
  final double? size;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) => Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Padding(
              padding: padding ?? const EdgeInsets.only(top: 27.0),
              child: Icon(
                TIcons.logo,
                color: isDarkMode ? TColors.base100.withOpacity(.4) : TColors.secondary.withOpacity(.5),
                size: size ?? 110.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                'K Y W',
                style: GoogleFonts.roboto(
                  fontSize: 45,
                  color: isDarkMode ? TColors.base100 : TColors.secondary,
                ),
              ),
            ),
          ],
        ),
      );
}
