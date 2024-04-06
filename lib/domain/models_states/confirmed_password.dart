import 'package:formz/formz.dart';
import 'package:kyw_management/domain/services/mixins/validations_mixin.dart';

enum ConfirmedPasswordValidationError { invalid }

class ConfirmedPassword extends FormzInput<String, ConfirmedPasswordValidationError> with ValidationsMixin {
  const ConfirmedPassword.pure({this.password = ''}) : super.pure('');
  const ConfirmedPassword.dirty({required this.password, String value = ''}) : super.dirty(value);

  final String password;

  @override
  ConfirmedPasswordValidationError? validator(String value) {
    final passwordIsValid =
        combine([() => isNotEmpty(value), () => isSixChars(value), () => isEquals(password, value)]);

    return passwordIsValid == null ? null : ConfirmedPasswordValidationError.invalid;
  }
}
