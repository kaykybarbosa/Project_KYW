part of 'change_number_cubit.dart';

class ChangeNumberState extends Equatable {
  const ChangeNumberState({
    this.newNumber = const NewNumber.pure(),
    this.currentNumber = const CurrentNumber.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final NewNumber newNumber;
  final CurrentNumber currentNumber;
  final bool isValid;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [newNumber, currentNumber, isValid, status];

  ChangeNumberState copyWith({
    NewNumber? newNumber,
    CurrentNumber? currentNumber,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return ChangeNumberState(
      newNumber: newNumber ?? this.newNumber,
      currentNumber: currentNumber ?? this.currentNumber,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }
}
