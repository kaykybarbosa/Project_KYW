import 'package:kyw_management/domain/blocs/blocs_export.dart';
import 'package:kyw_management/domain/services/mixins/validations_mixin.dart';

enum NewNumberValidationError { invalid }

class NewNumber extends FormzInput<String, NewNumberValidationError>
    with ValidationsMixin {
  const NewNumber.pure([super.value = '']) : super.pure();
  const NewNumber.dirty([super.value = '']) : super.dirty();

  @override
  NewNumberValidationError? validator(String value) {
    final newNumber = combine([
      () => isNotEmpty(value),
      () => numberIsValid(value),
    ]);

    return newNumber == null ? null : NewNumberValidationError.invalid;
  }
}
