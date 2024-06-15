import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../models_input/models_states_export.dart';

part 'change_phone_state.dart';

class ChangePhoneCubit extends Cubit<ChangePhoneState> {
  ChangePhoneCubit() : super(const ChangePhoneState());

  void newPhoneChanged(String value) {
    final newPhone = PhoneInput.dirty(value);

    emit(
      state.copyWith(
        newPhone: newPhone,
        isValid: Formz.validate([newPhone, state.currentPhone]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void currentPhoneChanged(String value) {
    final currentPhone = PhoneInput.dirty(value);

    emit(
      state.copyWith(
        currentPhone: currentPhone,
        isValid: Formz.validate([state.newPhone, currentPhone]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void formChangePhoneSubmitted() async {
    if (!state.isValid) return;

    emit(const ChangePhoneState(status: FormzSubmissionStatus.inProgress));
    await Future<void>.delayed(const Duration(seconds: 2));
    emit(const ChangePhoneState(status: FormzSubmissionStatus.success));
  }
}
