import 'package:formz/formz.dart';
import 'package:kyw_management/data/services/mixins/validations_mixin.dart';

class PasswordInput extends FormzInput<String, String> with ValidationsMixin {
  const PasswordInput.pure([super.value = '']) : super.pure();
  const PasswordInput.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(value) => combine([
        () => isNotEmpty(value, 'Senha obrigatório.'),
        () => isSixChars(value, 'Sua senha deve conter pelo menos 6 caracteres.'),
      ]);
}
