import 'package:formz/formz.dart';
import 'package:kyw_management/data/services/mixins/validations_mixin.dart';

class TitleModel extends FormzInput<String, String> with ValidationsMixin {
  const TitleModel.pure([super.value = '']) : super.pure();
  const TitleModel.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) => combine([() => isNotEmpty(value)]);
}
