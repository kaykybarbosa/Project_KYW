import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/ui/state_management/models_input/email_input.dart';

part 'change_email_state.dart';

class ChangeEmailCubit extends Cubit<ChangeEmailState> {
  ChangeEmailCubit() : super(const ChangeEmailState());

  void newEmailChanged(String value) {
    final newEmail = EmailInput.dirty(value);

    emit(
      state.copyWith(
        newEmail: newEmail,
        isValid: Formz.validate([newEmail, state.currentEmail]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void currentEmailChanged(String value) {
    final currentEmail = EmailInput.dirty(value);

    emit(
      state.copyWith(
        newEmail: currentEmail,
        isValid: Formz.validate([state.newEmail, currentEmail]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void formChangeEmailSubmitted() async {
    if (!state.isValid) return;

    emit(const ChangeEmailState(status: FormzSubmissionStatus.inProgress));
    await Future<void>.delayed(const Duration(seconds: 2));
    emit(const ChangeEmailState(status: FormzSubmissionStatus.success));
  }
}
