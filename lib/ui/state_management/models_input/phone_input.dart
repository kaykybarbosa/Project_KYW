import 'package:formz/formz.dart';
import 'package:kyw_management/data/services/mixins/validations_mixin.dart';

class PhoneInput extends FormzInput<String, String> with ValidationsMixin {
  const PhoneInput.pure([super.value = '']) : super.pure();
  const PhoneInput.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) => combine([
        () => isNotEmpty(value, 'Telefone obrigatório.'),
        () => phoneIsValid(value, 'Telefone inválido.'),
      ]);
}
