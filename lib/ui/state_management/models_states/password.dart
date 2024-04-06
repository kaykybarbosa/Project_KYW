import 'package:formz/formz.dart';
import 'package:kyw_management/data/services/mixins/validations_mixin.dart';

class Password extends FormzInput<String, String> with ValidationsMixin {
  const Password.pure([super.value = '']) : super.pure();
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(value) => combine([
        () => isNotEmpty(value),
        () => isSixChars(value),
      ]);
}
