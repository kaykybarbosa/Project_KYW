import 'package:kyw_management/domain/blocs/blocs_export.dart';

class DateModel extends FormzInput<String, String> {
  const DateModel.pure([super.value = '']) : super.pure();
  const DateModel.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    throw UnimplementedError();
  }
}
