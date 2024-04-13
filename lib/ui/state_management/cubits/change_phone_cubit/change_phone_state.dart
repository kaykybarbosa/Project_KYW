part of 'change_phone_cubit.dart';

class ChangePhoneState extends Equatable {
  const ChangePhoneState({
    this.newPhone = const PhoneInput.pure(),
    this.currentPhone = const PhoneInput.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final PhoneInput newPhone;
  final PhoneInput currentPhone;
  final bool isValid;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [newPhone, currentPhone, isValid, status];

  ChangePhoneState copyWith({
    PhoneInput? newPhone,
    PhoneInput? currentPhone,
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
