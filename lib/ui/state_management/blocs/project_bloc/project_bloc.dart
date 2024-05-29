import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/data/dtos/request/message_request.dart';
import 'package:kyw_management/data/dtos/response/all_projects_response.dart';
import 'package:kyw_management/data/repositories/project_repository.dart';
import 'package:kyw_management/data/services/message_service.dart';
import 'package:kyw_management/domain/models/project_model.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc({
    required IProjectRepository projectRepository,
    required IMessageService messageService,
    required AppController appController,
  })  : _repository = projectRepository,
        _messageService = messageService,
        _controller = appController,
        super(ProjectState()) {
    on<GetAllProjects>(_onGetAllProject);
    on<AddProject>(_onAddProject);
    on<GetProjectById>(_onGetById);
    on<ConnectWebSocket>(_connectWebSocket);
    on<SendMessage>(_sendMessage);
  }

  final IProjectRepository _repository;
  final IMessageService _messageService;
  final AppController _controller;

  void _onGetAllProject(GetAllProjects event, Emitter<ProjectState> emit) async {
    if (state.allProjects.content.isNotEmpty) return;

    emit(state.copyWith(status: ProjectStatus.inProgress));

    var result = await _repository.getAllProjects();

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

  void _onAddProject(AddProject event, Emitter<ProjectState> emit) {}

  void _onGetById(GetProjectById event, Emitter<ProjectState> emit) async {
    emit(state.copyWith(status: ProjectStatus.detailInProgress));

    var result = await _repository.getProjectById(event.projectId);

    result.fold(
      (success) => emit(state.copyWith(
        detailProject: success,
        status: ProjectStatus.detailSuccess,
      )),
      (failure) => emit(state.copyWith(status: ProjectStatus.detailFailure)),
    );
  }

  void _connectWebSocket(ConnectWebSocket event, Emitter<ProjectState> emit) {
    final projects = state.allProjects.content;
    if (projects.isNotEmpty) {
      for (var project in projects) {
        log('Subscribe in project: ${project.id}', name: 'WEBSOCKET');

        _messageService.subscribeToMessageUpdates(
            projectId: project.id,
            onMessageReceived: (value) {
              log('$value', name: 'WEBSOCKET');
            });
      }
    }
  }

  void _sendMessage(SendMessage event, Emitter<ProjectState> emit) async {
    final currentUser = await _controller.currentUser;
    final message = MessageRequest(
      userId: currentUser!.id,
      message: event.message,
    );

    _messageService.sendMessage(projectId: event.projectId, message: message);
  }
}
