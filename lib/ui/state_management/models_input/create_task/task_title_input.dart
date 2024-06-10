import 'package:formz/formz.dart';
import 'package:kyw_management/data/mixins/validations_mixin.dart';

class TaskTitleInput extends FormzInput<String, String> with ValidationsMixin {
  const TaskTitleInput.pure([super.value = '']) : super.pure();
  const TaskTitleInput.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) => combine([
        () => isNotEmpty(value, 'Título obrigatório.'),
      ]);
}
