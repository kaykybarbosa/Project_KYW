import 'package:formz/formz.dart';
import 'package:kyw_management/data/mixins/validations_mixin.dart';

class CategoryInput extends FormzInput<String, String> with ValidationsMixin {
  const CategoryInput.pure([super.value = '']) : super.pure();
  const CategoryInput.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) => combine([
        () => isNotEmpty(value, 'Categoria obrigatório.'),
      ]);
}
