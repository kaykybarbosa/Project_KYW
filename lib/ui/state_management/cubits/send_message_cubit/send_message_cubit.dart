import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/data/dtos/request/message_request.dart';
import 'package:kyw_management/data/services/message_service.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit({required AppController appController, required IMessageService messageService})
      : _controller = appController,
        _service = messageService,
        super(const SendMessageState());

  final AppController _controller;
  final IMessageService _service;

  String? getMessageToProject(String projectId) {
    final message = state.messages.firstWhereOrNull((message) => message.projectId == projectId);

    return message?.value;
  }

  void messageChanged(String projectId, String value) {
    final messages = List<MessageCubit>.from(state.messages);

    final message = messages.firstWhereOrNull((message) => message.projectId == projectId);

    if (message != null) {
      messages.remove(message);
      messages.add(message.copyWith(value: value));
    } else {
      messages.add(MessageCubit(projectId: projectId, value: value));
    }

    emit(state.copyWith(messages: messages));

    log('Messages: [$messages]', name: 'MESSAGETEST');
  }

  void sendMessage(String projectId) async {
    final message = state.messages.firstWhereOrNull((message) => message.projectId == projectId);

    if (message == null || message.value.isEmpty) return;

    final currentUser = _controller.currentUser;

    final request = MessageRequest(
      userId: currentUser.id,
      message: message.value,
    );

    var result = await _service.sendMessage(projectId: projectId, message: request);

    result.fold(
      (_) {
        final messages = List<MessageCubit>.from(state.messages)..remove(message);

        emit(state.copyWith(messages: messages));

        log('Message sended: $message', name: 'WEBSOCKET');
      },
      (failure) => {
        emit(state.copyWith(status: FormzSubmissionStatus.failure)),
        log('Message not sended: $message', name: 'WEBSOCKET'),
      },
    );
  }
}
