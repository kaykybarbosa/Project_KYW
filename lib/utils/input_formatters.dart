import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

abstract class InputFormatters {
  static MaskTextInputFormatter date = MaskTextInputFormatter(
    mask: '##/##/####',
    type: MaskAutoCompletionType.lazy,
  );
  static MaskTextInputFormatter phone = MaskTextInputFormatter(
    mask: '(##) #####-####',
    type: MaskAutoCompletionType.lazy,
  );
}
