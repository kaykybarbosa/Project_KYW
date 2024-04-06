import 'package:formz/formz.dart';
import 'package:kyw_management/data/services/mixins/validations_mixin.dart';

class ConfirmedPassword extends FormzInput<String, String> with ValidationsMixin {
  const ConfirmedPassword.pure({this.password = ''}) : super.pure('');
  const ConfirmedPassword.dirty({required this.password, String value = ''}) : super.dirty(value);

  final String password;

  @override
  String? validator(String value) => combine([
        () => isNotEmpty(value),
        () => isSixChars(value),
        () => isEquals(password, value),
      ]);
}
