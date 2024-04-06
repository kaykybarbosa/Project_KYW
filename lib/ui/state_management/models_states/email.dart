import 'package:formz/formz.dart';
import 'package:kyw_management/data/services/mixins/validations_mixin.dart';

enum EmailValidationError { invalid }

class Email extends FormzInput<String, EmailValidationError> with ValidationsMixin {
  const Email.pure([super.value = '']) : super.pure();
  const Email.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    final emailValid = combine([
      () => isNotEmpty(value),
      () => isEmailValid(value),
    ]);
    return emailValid == null ? null : EmailValidationError.invalid;
  }
}
