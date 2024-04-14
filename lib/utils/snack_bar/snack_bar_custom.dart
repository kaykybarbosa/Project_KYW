import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyw_management/domain/enums/snack_bar_type.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/icons.dart';

SnackbarController snackBarCustom({
  String title = 'Ops... Algo deu errado.',
  String? message,
  SnackBarType type = SnackBarType.success,
  Duration? duration = const Duration(seconds: 3),
  bool? showMessageText = true,
}) {
  var message_ = 'Não foi possível completar sua solicitação';

  if (message != null && message != 'null') message_ = message;

  return Get.snackbar(
    title,
    message_,
    icon: Icon(
      _iconType(type),
      color: TColors.base100,
    ),
    duration: duration,
    colorText: TColors.base100,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: _backgroundColorType(type),
    messageText: showMessageText! ? null : Container(),
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  );
}

Color _backgroundColorType(SnackBarType type) => switch (type) {
      SnackBarType.failure => TColors.warn,
      SnackBarType.danger => TColors.warn,
      _ => TColors.success,
    };

IconData _iconType(SnackBarType type) => switch (type) {
      SnackBarType.failure => TIcons.circleClose,
      SnackBarType.danger => TIcons.triangleExclamation,
      _ => TIcons.check,
    };
