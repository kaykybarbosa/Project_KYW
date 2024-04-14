import 'package:formz/formz.dart';
import 'package:kyw_management/data/mixins/validations_mixin.dart';

class ConfirmedPasswordInput extends FormzInput<String, String> with ValidationsMixin {
  const ConfirmedPasswordInput.pure({this.password = ''}) : super.pure('');
  const ConfirmedPasswordInput.dirty({required this.password, String value = ''}) : super.dirty(value);

  final String password;

  @override
  String? validator(String value) => combine([
        () => isNotEmpty(value, 'Campo obrigatório.'),
        () => isEquals(password, value, 'As senhas não coincidem.'),
      ]);
}
