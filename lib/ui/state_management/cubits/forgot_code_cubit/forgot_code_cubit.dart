import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/ui/state_management/models_input/code_input.dart';

part 'forgot_code_state.dart';

class ForgotCodeCubit extends Cubit<ForgotCodeState> {
  ForgotCodeCubit() : super(const ForgotCodeState());

  void codeChanged(String value) {
    final code = CodeInput.dirty(value);
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

    final code = CodeInput.dirty(state.code.value);
    String codeValidationExample = '123456';

    if (codeValidationExample == code.value) {
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
