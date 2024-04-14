import 'package:formz/formz.dart';
import 'package:kyw_management/data/mixins/validations_mixin.dart';

class CodeInput extends FormzInput<String, String> with ValidationsMixin {
  const CodeInput.pure([super.value = '']) : super.pure();
  const CodeInput.dirty([super.value = '']) : super.dirty();

  /// TODO: Revisar validação.
  @override
  String? validator(String value, [String? compareValue]) => combine([
        () => isNotEmpty(value, 'Código obrigatório.'),
        () => isEquals(value, compareValue ?? value),
      ]);
}
