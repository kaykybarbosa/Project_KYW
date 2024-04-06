// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forgot_code_cubit.dart';

class ForgotCodeState extends Equatable {
  const ForgotCodeState({
    this.code = const Code.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final Code code;
  final bool isValid;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [code, isValid, status];

  ForgotCodeState copyWith({
    Code? code,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return ForgotCodeState(
      code: code ?? this.code,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }
}
