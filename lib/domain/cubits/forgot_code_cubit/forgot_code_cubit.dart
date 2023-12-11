import 'package:equatable/equatable.dart';
import 'package:kyw_management/domain/blocs/blocs_export.dart';

import '../../models/models_export.dart';

part 'forgot_code_state.dart';

class ForgotCodeCubit extends Cubit<ForgotCodeState> {
  ForgotCodeCubit() : super(const ForgotCodeState());

  void codeChanged(String value) {
    final code = Code.dirty(value);
    emit(
      state.copyWith(
        code: code,
        isValid: Formz.validate([code]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void formSubmitted() async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    await Future<void>.delayed(const Duration(seconds: 2));

    final code = Code.dirty(state.code.value);
    String codeValidationExample = '123456';

    if (codeValidationExample == code.value) {
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
