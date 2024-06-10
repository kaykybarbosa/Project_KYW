import 'package:formz/formz.dart';
import 'package:kyw_management/data/mixins/validations_mixin.dart';

class NameInput extends FormzInput<String, String> with ValidationsMixin {
  const NameInput.pure([super.value = '']) : super.pure();
  const NameInput.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) => combine([
        () => isNotEmpty(value, 'Nome obrigatório.'),
        () => isSixChars(value, 'Nome deve conter pelo menos 6 caracteres.'),
      ]);
}
