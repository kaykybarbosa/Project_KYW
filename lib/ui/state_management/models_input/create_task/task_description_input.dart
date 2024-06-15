import 'package:formz/formz.dart';
import 'package:kyw_management/data/mixins/validations_mixin.dart';

class TaskDescriptionInput extends FormzInput<String, String> with ValidationsMixin {
  const TaskDescriptionInput.pure([super.value = '']) : super.pure();
  const TaskDescriptionInput.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) => combine([]);
}
