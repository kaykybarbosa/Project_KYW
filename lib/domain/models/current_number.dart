import 'package:kyw_management/domain/blocs/blocs_export.dart';
import 'package:kyw_management/domain/services/mixins/validations_mixin.dart';

enum CurrentNumberValidationError { invalid }

class CurrentNumber extends FormzInput<String, CurrentNumberValidationError>
    with ValidationsMixin {
  const CurrentNumber.pure([super.value = '']) : super.pure();
  const CurrentNumber.dirty([super.value = '']) : super.dirty();

  @override
  CurrentNumberValidationError? validator(String value) {
    final numberValid = combine([
      () => isNotEmpty(value),
      () => numberIsValid(value),
    ]);

    return numberValid == null ? null : CurrentNumberValidationError.invalid;
  }
}
