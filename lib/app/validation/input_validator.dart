import 'package:email_validator/email_validator.dart';

class InputValidator {
  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Digite seu nome';
    } else if (name.length < 4) {
      return 'Seu nome deve conter no mínimo 4 caracteres';
    } else if (name.length > 30) {
      return 'Seu nome deve conter no máximo 30 caracteres';
    }

    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Digite seu email';
    }

    if (!EmailValidator.validate(email)) {
      return 'Digite um e-mail válido';
    }

    return null;
  }

  static String? validatePassword({String? password, bool isLogin = false}) {
    if (password == null || password.isEmpty) {
      if (isLogin) {
        return 'Digite sua senha';
      }

      return 'Digite uma senha';
    }

    if (password.length < 6 && !isLogin) {
      return 'Sua senha deve conter no mínimo 6 caracteres';
    }

    if (password.length > 15 && !isLogin) {
      return 'Sua senha deve conter no máximo 15 caracteres';
    }

    return null;
  }

  static String? validatePasswordConfirm(
      {String? passwordConfirm, String? password}) {
    if (passwordConfirm != password) {
      return 'As senhas não consistem';
    }

    return null;
  }

  static String? validateCode({String? code, String? confirmCode}) {
    if (code == null || code.isEmpty) {
      return 'Digite o código para avançar';
    }

    if (confirmCode != null) {
      if ((code.compareTo(confirmCode.toString())) != 0) {
        return 'Código inválido';
      }
    }

    return null;
  }
}
