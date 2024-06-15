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
        fit: BoxFit.contain,
        width: width,
        height: height,
      ),
    );
  }
}
