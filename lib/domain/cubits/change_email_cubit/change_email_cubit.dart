import 'package:equatable/equatable.dart';
import 'package:kyw_management/domain/blocs/blocs_export.dart';
import 'package:kyw_management/domain/models_states/email.dart';

part 'change_email_state.dart';

class ChangeEmailCubit extends Cubit<ChangeEmailState> {
  ChangeEmailCubit() : super(const ChangeEmailState());

  void newEmailChanged(String value) {
    final newEmail = Email.dirty(value);

    emit(
      state.copyWith(
        newEmail: newEmail,
        isValid: Formz.validate([newEmail, state.currentEmail]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void currentEmailChanged(String value) {
    final currentEmail = Email.dirty(value);

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
