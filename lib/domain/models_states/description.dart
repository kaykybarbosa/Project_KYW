import 'package:formz/formz.dart';
import 'package:kyw_management/domain/services/mixins/validations_mixin.dart';

enum DescriptionValidationError { invalid }

class Description extends FormzInput<String, DescriptionValidationError>
    with ValidationsMixin {
  const Description.pure([super.value = '']) : super.pure();
  const Description.dirty([super.value = '']) : super.dirty();

  @override
  DescriptionValidationError? validator(String value) {
    final description = combine([() => isNotEmpty(value)]);

    return description == null ? null : DescriptionValidationError.invalid;
  }
}
