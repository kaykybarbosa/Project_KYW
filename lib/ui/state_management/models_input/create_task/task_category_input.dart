import 'package:formz/formz.dart';
import 'package:kyw_management/data/mixins/validations_mixin.dart';

class TaskCategoryInput extends FormzInput<String, String> with ValidationsMixin {
  const TaskCategoryInput.pure([super.value = '']) : super.pure();
  const TaskCategoryInput.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) => combine([
        () => isNotEmpty(value, 'Categoria obrigatório.'),
      ]);
}
