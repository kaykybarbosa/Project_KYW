import 'package:get/get.dart';

mixin ValidationsMixin {
  String? isNotEmpty(String? value, [String? message]) {
    if (value!.isEmpty) {
      return message ?? 'Este campo é obrigatório';
    }
    return null;
  }

  String? isEmailValid(String? email, [String? message]) {
    if (!email!.isEmail) {
      return message ?? 'E-mail inválido.';
    }
    return null;
  }

  String? isEquals(String? value, String? valueConfirm, [String? message]) {
    if (value != valueConfirm) {
      return message ?? 'Os campos não coincidem';
    }
    return null;
  }

  String? isSixChars(String? value, [String? message]) {
    if (value!.length < 6) {
      return message ?? 'Você deve usar pelo menos 6 caracteres!';
    }
    return null;
  }

  String? combine(List<String? Function()> validations) {
    for (final func in validations) {
      final validation = func();
      if (validation != null) {
        return validation;
      }
    }

    return null;
  }

  String? phoneIsValid(String? value, [String? message]) {
    if (value!.length != 11) {
      return message ?? 'Número de celular inválido';
    }

    RegExp regex = RegExp(r'.*[a-zA-Z].*');
    if (regex.hasMatch(value)) {
      return message ?? 'Número de celular inválido';
    }

    if (!value.startsWith('9')) {
      return message ?? 'Número de celular inválido';
    }

    return null;
  }

  String? dateIsValid(String? value, [String? message]) {
    DateTime? date;

    try {
      /// Primeira etapa
      date = DateTime.tryParse(value!);
      if (date == null) {
        return message ?? 'First';
      }

      /// Segunda etapa
      DateTime now = DateTime.now();
      DateTime firstDate = DateTime(now.year - 2, now.month, now.day);

      if (date.isBefore(firstDate)) {
        return message ?? 'Data é antiga!';
      }
      if (date.isAfter(now)) {
        return message ?? 'Data é posterior!';
      }

      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
