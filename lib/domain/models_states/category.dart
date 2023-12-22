import 'package:kyw_management/domain/blocs/blocs_export.dart';
import 'package:kyw_management/domain/services/mixins/validations_mixin.dart';

class Category extends FormzInput<String, String> with ValidationsMixin {
  const Category.pure([super.value = '']) : super.pure();
  const Category.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return combine([
      () => isNotEmpty(value),
    ]);
  }
}