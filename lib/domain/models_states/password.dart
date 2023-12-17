import 'package:formz/formz.dart';
import 'package:kyw_management/domain/services/mixins/validations_mixin.dart';

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError>
    with ValidationsMixin {
  const Password.pure([super.value = '']) : super.pure();
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(value) {
    final passwordValid = combine([
      () => isNotEmpty(value),
      () => isSixChars(value),
    ]);
    return passwordValid == null ? null : PasswordValidationError.invalid;
  }
}
