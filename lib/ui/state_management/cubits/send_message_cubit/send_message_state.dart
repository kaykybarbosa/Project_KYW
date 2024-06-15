// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'send_message_cubit.dart';

class SendMessageState extends Equatable {
  const SendMessageState({
    this.messages = const [],
    this.status = FormzSubmissionStatus.initial,
  });

  final List<MessageCubit> messages;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [messages, status];

  SendMessageState copyWith({List<MessageCubit>? messages, FormzSubmissionStatus? status}) {
    return SendMessageState(
      messages: messages ?? this.messages,
      status: status ?? FormzSubmissionStatus.initial,
    );
  }
}

class MessageCubit extends Equatable {
  const MessageCubit({this.projectId = '', this.value = ''});

  final String projectId;
  final String value;

  @override
  List<Object?> get props => [projectId, value];

  MessageCubit copyWith({
    String? projectId,
    String? value,
  }) {
    return MessageCubit(
      projectId: projectId ?? this.projectId,
      value: value ?? this.value,
    );
  }
}
