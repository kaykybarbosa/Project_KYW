import 'package:flutter/material.dart';
import 'package:kyw_management/ui/widgets/app_logo.dart';
import 'package:kyw_management/ui/widgets/my_system_ui_overlay.dart';
import 'package:kyw_management/utils/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
    this.padding,
    this.size,
    this.progressVisible,
  });

  /// Valor padrão: 110.0.
  final double? size;

  /// Valor padrão: EdgeInsets.only(top: 27.0).
  final EdgeInsetsGeometry? padding;

  /// Valor padrão: false.
  final bool? progressVisible;

  @override
  Widget build(BuildContext context) => MySystemUiOverlay(
        isDarkMode: true,
        child: Stack(
          children: <Widget>[
            /// Background
            Container(color: TColors.secondary),

            /// Logo
            AppLogo(padding: padding, size: size, isDarkMode: true),

            /// Progress indicator
            Visibility(
              visible: progressVisible ?? false,
              child: const Align(
                alignment: Alignment(0.0, 0.5),
                child: CircularProgressIndicator(color: TColors.base100),
              ),
            )
          ],
        ),
      );
}
