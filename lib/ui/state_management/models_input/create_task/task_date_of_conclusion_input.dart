import 'package:formz/formz.dart';
import 'package:kyw_management/data/mixins/validations_mixin.dart';

class TaskDateOfConclusionInput extends FormzInput<String, String> with ValidationsMixin {
  const TaskDateOfConclusionInput.pure([super.value = '']) : super.pure();
  const TaskDateOfConclusionInput.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) => combine([
        () => isNotEmpty(value, 'Data de conclusão obrigatório.'),
        () => dateIsValid(
              value,
              'Data de conclusão inválida.',
              DateTime.now().year - 2,
            ),
      ]);
}
