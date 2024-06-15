import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/domain/enums/dialog_type.dart';
import 'package:kyw_management/ui/widgets/my_elevated_button_card.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/icons.dart';

/// Retorna um dialog animado e customizável.
///
/// [context] - paramêtro obrigatório.
///
/// [title] - título principal do dialog. Caso seja null, é adicionado uma valor vazio ' '.
///
/// [desc] - descrição do dialog. Caso seja null, é adicionado um valor vazio ' '.
///
/// [cancelText] - label do botão de cancelar. Valor padrão é 'Cancelar'.
///
/// [okText] - label do botão de confirmar. Valor padrão é 'Ok'.
///
/// [type] - difine o estilo que o dialog irá receber. Com base nos tipos [DialogType].
/// Valor padrão é [DialogType.dialogDefault].
///
/// [cancelVisible] - define se botão de cancelar estará visível. Valor padrão é false.
///
/// [showMainIcon] - define se ícone principal estará visível. Valor padrão é true.
///
/// [isBiometricsDialog] - se true, será usado o [mainIcon] como ícone principal.
///
/// [closeVisible] - define se ícone de fechar dialog estará visível. Valor padrão é true.
///
/// [mainIcon] - ícone principal do dialog. Caso seja null, seu valor padrão é [FontAwesomeIcons.question].
///
/// [okForegroundColor] - define a cor do [okButton]. Valor padrão é [MyColors.primary].
///
/// [cancelOnTap] - função que será chamanda ao clicar no botão de cancelar. Valor padrão é Get.Back().
///
/// [okOnTap] - função que será chamanda ao clicar no botão de confirmar. Valor padrão é Get.Back().
///
/// [closeOnTap] - função que será chamanda ao clicar no botão para fechar dialog. Valor padrão é Get.Back().
///
Future<String?> dialogCustom(
  BuildContext context, {
  String? title,
  String? desc,
  String cancelText = 'Cancelar',
  String okText = 'Ok',
  DialogType type = DialogType.dialogDefault,
  bool cancelVisible = false,
  bool showMainIcon = true,
  bool isBiometricsDialog = false,
  bool closeVisible = false,
  IconData? mainIcon,
  Color? okForegroundColor,
  Function()? cancelOnTap,
  Function()? okOnTap,
  Function()? closeOnTap,
}) =>
    showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierColor: TColors.base900.withOpacity(0.5),
      pageBuilder: (context, _, __) => Container(),
      transitionBuilder: (context, a1, _, widget) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: ScaleTransition(
          scale: Tween<double>(begin: .5, end: 1.0).animate(a1),
          child: Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TConstants.cardRadiusSm)),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _firstColor(type),
                    width: 6,
                  ),
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(TConstants.cardRadiusSm - 5),
                  bottom: Radius.circular(TConstants.cardRadiusSm - 3),
                ),
              ),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(TConstants.cardRadiusSm),
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        /// Ícone
                        Visibility(
                          visible: showMainIcon,
                          replacement: const Gap(10),
                          child: _Icon(
                            type: type,
                            icon: mainIcon,
                            isBiometricsDialog: isBiometricsDialog,
                          ),
                        ),

                        /// Título
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 5),
                            child: Text(
                              title ?? '',
                              style: GoogleFonts.poppins(
                                fontSize: TConstants.fontSizeLg + 1,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                        /// Descrição
                        Visibility(
                          visible: desc != null,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              desc ?? '',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(color: Theme.of(context).colorScheme.onSurface),
                            ),
                          ),
                        ),
                        const Gap(25),

                        /// Botões
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Theme.of(context).dividerTheme.color!),
                            ),
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(TConstants.cardRadiusSm),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              /// -- Cancelar
                              Visibility(
                                visible: cancelVisible,
                                child: Expanded(
                                  child: MyElevatedButtonCard(
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                                    onPressed: cancelOnTap ?? () => Get.back(),
                                    child: Text(cancelText.toUpperCase()),
                                  ),
                                ),
                              ),

                              /// -- Confirmar
                              Expanded(
                                child: MyElevatedButtonCard(
                                  isAlone: !cancelVisible,
                                  isRight: cancelVisible,
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: okForegroundColor ?? TColors.secondary,
                                  onPressed: okOnTap ?? () => Get.back(),
                                  child: Text(
                                    okText.toUpperCase(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

class _Icon extends StatelessWidget {
  const _Icon({
    required this.type,
    IconData? icon,
    this.isBiometricsDialog = false,
  }) : _icon = icon;

  final DialogType type;
  final IconData? _icon;
  final bool isBiometricsDialog;

  @override
  Widget build(BuildContext context) {
    /// Terceira cor
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _thirdColor(type),
        borderRadius: const BorderRadius.all(Radius.circular(45)),
      ),

      /// Segunda cor
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _secondColor(type),
          borderRadius: const BorderRadius.all(Radius.circular(35)),
        ),

        /// Primeira cor
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _firstColor(type),
            borderRadius: const BorderRadius.all(Radius.circular(25)),
          ),

          /// -- Ícone
          child: _IconData(icon: _icon, type: type),
        ),
      ),
    );
  }
}

class _IconData extends StatelessWidget {
  const _IconData({required IconData? icon, required this.type}) : _icon = icon;

  final IconData? _icon;
  final DialogType type;

  @override
  Widget build(BuildContext context) => Icon(
        _icon ?? _iconType(type),
        color: TColors.base100,
        size: 30,
      );
}

IconData _iconType(DialogType type) => switch (type) {
      DialogType.failure => TIcons.close,
      DialogType.warning => TIcons.exclamation,
      DialogType.success => TIcons.check,
      _ => TIcons.question,
    };

Color _firstColor(DialogType type) => switch (type) {
      DialogType.failure => TColors.warn,
      DialogType.warning => TColors.alert,
      DialogType.success => TColors.success,
      _ => TColors.secondary,
    };

Color _secondColor(DialogType type) => switch (type) {
      DialogType.failure => TColors.redLight,
      DialogType.warning => TColors.yellowLight,
      DialogType.success => TColors.greenLight,
      _ => TColors.secondaryLight,
    };

Color _thirdColor(DialogType type) => switch (type) {
      DialogType.failure => TColors.redExtraLight,
      DialogType.warning => TColors.yellowExtraLight,
      DialogType.success => TColors.greenExtraLight,
      _ => TColors.secondaryExtraLight,
    };
