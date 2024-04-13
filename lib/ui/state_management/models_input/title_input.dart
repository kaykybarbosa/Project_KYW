import 'package:formz/formz.dart';
import 'package:kyw_management/data/services/mixins/validations_mixin.dart';

class TitleInput extends FormzInput<String, String> with ValidationsMixin {
  const TitleInput.pure([super.value = '']) : super.pure();
  const TitleInput.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) => combine([
        () => isNotEmpty(value, 'Título obrigatório.'),
      ]);
}
