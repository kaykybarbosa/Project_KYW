import 'package:formz/formz.dart';
import 'package:kyw_management/data/services/mixins/validations_mixin.dart';

class Code extends FormzInput<String, String> with ValidationsMixin {
  const Code.pure([super.value = '']) : super.pure();
  const Code.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value, [String? compareValue]) => combine([
        () => isNotEmpty(value),
        () => isEquals(value, compareValue ?? value),
      ]);
}
