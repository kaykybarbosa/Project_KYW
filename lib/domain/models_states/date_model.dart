import 'package:kyw_management/domain/blocs/blocs_export.dart';
import 'package:kyw_management/domain/services/mixins/validations_mixin.dart';

class DateModel extends FormzInput<String, String> with ValidationsMixin {
  const DateModel.pure([super.value = '']) : super.pure();
  const DateModel.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    final date = combine([
      () => isNotEmpty(value),
      () => dateIsValid(value),
    ]);

    return date;
  }
}
