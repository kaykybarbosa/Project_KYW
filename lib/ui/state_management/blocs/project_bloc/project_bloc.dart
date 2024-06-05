import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/data/dtos/response/all_projects_response.dart';
import 'package:kyw_management/data/dtos/response/detail_project_response.dart';
import 'package:kyw_management/data/dtos/response/message_response.dart';
import 'package:kyw_management/data/repositories/project_repository.dart';
import 'package:kyw_management/data/services/message_service.dart';
import 'package:kyw_management/data/storages/message_storage/message_storage.dart';
import 'package:kyw_management/domain/models/message_model.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc({
    required IProjectRepository projectRepository,
    required IMessageService messageService,
    required IMessageStorage messageStorage,
    required AppController appController,
  })  : _repository = projectRepository,
        _messageService = messageService,
        _storage = messageStorage,
        _controller = appController,
        super(ProjectState()) {
    on<GetAllProjects>(_onGetAllProject);
    on<GetProjectById>(_onGetById);
    on<SubscribeInProjectsWs>(_subscribeInProjectsWs);
    on<HasNewMessage>(_hasNewMessage);
    on<DeleteMessages>(_deleteMessages);
  }

  final IProjectRepository _repository;
  final IMessageService _messageService;
  final IMessageStorage _storage;
  final AppController _controller;

  String get _currentUserId => _controller.currentUser.id;

  ProjectResponse getProjectById(String projectId) {
    return state.allProjects.content.firstWhere((project) => project.projectId == projectId);
  }

  void _onGetAllProject(GetAllProjects event, Emitter<ProjectState> emit) async {
    if (state.allProjects.content.isNotEmpty) return;

    emit(state.copyWith(status: ProjectStatus.inProgress));

    var result = await _repository.getAllProjects(_currentUserId);

    result.fold(
      (success) {
        emit(state.copyWith(
          allProjects: success,
          status: ProjectStatus.success,
        ));
      },
      (failure) => emit(state.copyWith(status: ProjectStatus.failure)),
    );
  }

  void _onGetById(GetProjectById event, Emitter<ProjectState> emit) async {
    emit(state.copyWith(status: ProjectStatus.detailInProgress));

    List<MessageResponse> messages = [];
    final result = await _repository.getProjectById(event.projectId);

    if (result.isSuccess()) {
      messages = await _messageService.getMessages(
        event.projectId,
      );
    }

    result.fold(
      (success) => emit(state.copyWith(
        detailProject: success,
        status: ProjectStatus.detailSuccess,
        messages: messages,
      )),
      (failure) => emit(state.copyWith(status: ProjectStatus.detailFailure)),
    );
  }

  void _subscribeInProjectsWs(SubscribeInProjectsWs event, Emitter<ProjectState> emit) {
    final projects = state.allProjects.content;

    if (projects.isNotEmpty) {
      for (var project in projects) {
        log('Subscribe in project: ${project.projectId}', name: 'WEBSOCKET');

        _messageService.subscribeToMessageUpdates(
          projectId: project.projectId,
          onMessageReceived: (message) {
            log('Message received: $message', name: 'WEBSOCKET');
            event.onReceivedMessage(message);
          },
        );
      }
    }
  }

  void _hasNewMessage(HasNewMessage event, Emitter<ProjectState> emit) async {
    // final messages = _saveMessageToDB(event.message);

    final messages = await _messageService.getMessages(event.message.project.projectId);

    emit(state.copyWith(
      messages: messages,
      status: ProjectStatus.newMessage,
    ));
  }

  void _deleteMessages(DeleteMessages event, Emitter<ProjectState> emit) {
    final messages = _storage.getMessages(event.projectId, currentUserId: _currentUserId);

    _storage.deleteAllMessage(messages.map<int>((e) => e.id).toList());

    emit(state.copyWith());
  }

  List<MessageModel> _saveMessageToDB(MessageModel message) {
    message.currentUserId = _currentUserId;

    _storage.addMessage(message);

    return List<MessageModel>.from(state.messages)..add(message);
  }
}
