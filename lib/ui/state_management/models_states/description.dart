import 'package:formz/formz.dart';
import 'package:kyw_management/data/services/mixins/validations_mixin.dart';

class Description extends FormzInput<String, String> with ValidationsMixin {
  const Description.pure([super.value = '']) : super.pure();
  const Description.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) => combine([() => isNotEmpty(value)]);
}
