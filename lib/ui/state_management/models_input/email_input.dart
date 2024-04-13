import 'package:formz/formz.dart';
import 'package:kyw_management/data/services/mixins/validations_mixin.dart';

class EmailInput extends FormzInput<String, String> with ValidationsMixin {
  const EmailInput.pure([super.value = '']) : super.pure();
  const EmailInput.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) => combine([
        () => isNotEmpty(value, 'Email obrigatório.'),
        () => isEmailValid(value, 'Email inválido.'),
      ]);
}
