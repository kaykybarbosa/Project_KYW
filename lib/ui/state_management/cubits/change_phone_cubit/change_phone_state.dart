part of 'change_phone_cubit.dart';

class ChangePhoneState extends Equatable {
  const ChangePhoneState({
    this.newPhone = const Phone.pure(),
    this.currentPhone = const Phone.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final Phone newPhone;
  final Phone currentPhone;
  final bool isValid;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [newPhone, currentPhone, isValid, status];

  ChangePhoneState copyWith({
    Phone? newPhone,
    Phone? currentPhone,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return ChangePhoneState(
      newPhone: newPhone ?? this.newPhone,
      currentPhone: currentPhone ?? this.currentPhone,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }
}
