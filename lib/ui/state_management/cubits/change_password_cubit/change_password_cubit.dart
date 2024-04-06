import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/ui/state_management/models_states/models_states_export.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(const ChangePasswordState());

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.confirmedPassword]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );

    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([state.password, confirmedPassword]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void formChangePasswordSubmitted() async {
    if (!state.isValid) return;

    emit(const ChangePasswordState(status: FormzSubmissionStatus.inProgress));
    await Future<void>.delayed(const Duration(seconds: 2));
    emit(const ChangePasswordState(status: FormzSubmissionStatus.success));
  }
}
