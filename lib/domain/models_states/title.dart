import 'package:formz/formz.dart';
import 'package:kyw_management/domain/services/mixins/validations_mixin.dart';

enum TitleValidationError { invalid }

class Title extends FormzInput<String, TitleValidationError>
    with ValidationsMixin {
  const Title.pure([super.value = '']) : super.pure();
  const Title.dirty([super.value = '']) : super.dirty();

  @override
  TitleValidationError? validator(String value) {
    final title = combine([() => isNotEmpty(value)]);

    return title == null ? null : TitleValidationError.invalid;
  }
}
