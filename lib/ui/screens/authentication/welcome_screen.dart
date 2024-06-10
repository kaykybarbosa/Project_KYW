import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kyw_management/app/routers/my_routes.dart';
import 'package:kyw_management/ui/widgets/app_logo.dart';
import 'package:kyw_management/ui/widgets/my_elevated_button_underline.dart';
import 'package:kyw_management/ui/widgets/my_system_ui_overlay.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) => MySystemUiOverlay(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              /// App name
              const AppLogo(
                width: 150,
                height: 150,
                isDarkMode: true,
              ),

              /// Botões
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: TConstants.defaultMargin, vertical: 10),
                  decoration: const BoxDecoration(
                    color: TColors.base120,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: const _Buttons(),
                ),
              ),
            ],
          ),
        ),
      );
}

class _AppName extends StatelessWidget {
  const _AppName();

  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          'KYW',
          style: GoogleFonts.sofia(
            fontSize: 45,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      );
}

class _Buttons extends StatelessWidget {
  const _Buttons();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Gap(10),

            /// Criar conta
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: TColors.secondary),
                onPressed: () => Get.toNamed(AppRoutes.signUp),
                child: const Text('Criar conta'),
              ),
            ),
            const Gap(5),

            /// Acessar conta
            SizedBox(
              width: double.infinity,
              child: MyElevatedButtonUnderline(
                label: 'Acessar minha conta',
                onPressed: () => Get.toNamed(AppRoutes.signIn),
              ),
            ),
          ],
        ),
      );
}
