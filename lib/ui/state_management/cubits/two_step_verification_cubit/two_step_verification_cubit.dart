import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/ui/state_management/models_states/models_states_export.dart';

part 'two_step_verification_state.dart';

class TwoStepVerificationCubit extends Cubit<TwoStepVerificationState> {
  TwoStepVerificationCubit() : super(const TwoStepVerificationState());

  void emailChanged(String value) {
    final email = Email.dirty(value);

    emit(state.copyWith(
      email: email,
      isValid: Formz.validate([email]),
      status: FormzSubmissionStatus.initial,
    ));
  }

  void formTwoStepSubmitted() async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    await Future<void>.delayed(const Duration(seconds: 2));
    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }
}
