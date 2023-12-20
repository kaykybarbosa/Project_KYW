import 'package:formz/formz.dart';
import 'package:kyw_management/domain/services/mixins/validations_mixin.dart';

enum TitleValidationError { invalid }

class TitleModel extends FormzInput<String, TitleValidationError> with ValidationsMixin {
  const TitleModel.pure([super.value = '']) : super.pure();
  const TitleModel.dirty([super.value = '']) : super.dirty();

  @override
  TitleValidationError? validator(String value) {
    final title = combine([() => isNotEmpty(value)]);

    return title == null ? null : TitleValidationError.invalid;
  }
}
