import 'package:formz/formz.dart';
import 'package:kyw_management/data/services/mixins/validations_mixin.dart';

enum NameValidationError { invalid }

class Name extends FormzInput<String, NameValidationError> with ValidationsMixin {
  const Name.pure([super.value = '']) : super.pure();
  const Name.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    final nameValid = combine([
      () => isNotEmpty(value),
      () => isSixChars(value),
    ]);

    return nameValid == null ? null : NameValidationError.invalid;
  }
}
