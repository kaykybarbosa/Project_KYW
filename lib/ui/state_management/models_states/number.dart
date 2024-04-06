import 'package:formz/formz.dart';
import 'package:kyw_management/data/services/mixins/validations_mixin.dart';

enum PhoneValidationError { invalid }

class Phone extends FormzInput<String, PhoneValidationError> with ValidationsMixin {
  const Phone.pure([super.value = '']) : super.pure();
  const Phone.dirty([super.value = '']) : super.dirty();

  @override
  PhoneValidationError? validator(String value) {
    final phone = combine([
      () => isNotEmpty(value),
      () => phoneIsValid(value),
    ]);

    return phone == null ? null : PhoneValidationError.invalid;
  }
}
