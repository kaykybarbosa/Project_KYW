import 'package:formz/formz.dart';
import 'package:kyw_management/data/services/mixins/validations_mixin.dart';

enum CodeValidationError { invalid }

class Code extends FormzInput<String, CodeValidationError> with ValidationsMixin {
  const Code.pure([super.value = '']) : super.pure();
  const Code.dirty([super.value = '']) : super.dirty();

  @override
  CodeValidationError? validator(String value, [String? compareValue]) {
    final codeValid = combine([
      () => isNotEmpty(value),
      () => isEquals(value, compareValue ?? value),
    ]);

    return codeValid == null ? null : CodeValidationError.invalid;
  }
}
