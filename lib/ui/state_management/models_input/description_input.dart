import 'package:formz/formz.dart';
import 'package:kyw_management/data/services/mixins/validations_mixin.dart';

class DescriptionInput extends FormzInput<String, String> with ValidationsMixin {
  const DescriptionInput.pure([super.value = '']) : super.pure();
  const DescriptionInput.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) => combine([
        () => isNotEmpty(value, 'Descrição obrigatório.'),
      ]);
}
