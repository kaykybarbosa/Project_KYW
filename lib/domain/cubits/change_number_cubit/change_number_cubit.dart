import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../models/models_export.dart';

part 'change_number_state.dart';

class ChangeNumberCubit extends Cubit<ChangeNumberState> {
  ChangeNumberCubit() : super(const ChangeNumberState());

  void newNumberChanged(String value) {
    final newNumber = NewNumber.dirty(value);

    emit(
      state.copyWith(
        newNumber: newNumber,
        isValid: Formz.validate([newNumber, state.currentNumber]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void currentNumberChanged(String value) {
    final currentNumber = CurrentNumber.dirty(value);

    emit(
      state.copyWith(
        currentNumber: currentNumber,
        isValid: Formz.validate([state.newNumber, currentNumber]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void formChangeNumberSubmitted() async {
    if (!state.isValid) return;

    emit(const ChangeNumberState(status: FormzSubmissionStatus.inProgress));
    await Future<void>.delayed(const Duration(seconds: 2));
    emit(const ChangeNumberState(status: FormzSubmissionStatus.success));
  }
}
