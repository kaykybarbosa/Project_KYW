import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/data/dtos/response/all_projects_response.dart';
import 'package:kyw_management/data/repositories/project_repository.dart';
import 'package:kyw_management/data/services/message_service.dart';
import 'package:kyw_management/data/services/web_socket_client.dart';
import 'package:kyw_management/domain/models/project_model.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc({
    required IProjectRepository projectRepository,
    required WebSocketClient webSocket,
    required IMessageService messageService,
  })  : _repository = projectRepository,
        _ws = webSocket,
        _messageService = messageService,
        super(ProjectState()) {
    on<GetAllProjects>(_onGetAllProject);
    on<AddProject>(_onAddProject);
    on<GetProjectById>(_onGetById);
    on<ConnectWebSocket>(_connectWebSocket);
  }

  final IProjectRepository _repository;
  final WebSocketClient _ws;
  final IMessageService _messageService;

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

  void _cwonnectWebSocket(ConnectWebSocket event, Emitter<ProjectState> emit) {
    _ws.connect(
      'ws://10.0.0.100:8080/connect',
      {
        // 'Authorization': 'Bearer ....',
      },
    );

    _messageService.subscribeToMessageUpdates((Map<String, dynamic> message) {
      log('Received:  $message', name: 'WEBSOCKET');
    });
  }

  late StompClient stompClient;

  void _connectWebSocket(ConnectWebSocket event, Emitter<ProjectState> emit) async {
    final user = await AppController.instance.currentUser;

    log('INICIANDO CONEXÃO...', name: 'WEBSOCKET');

    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://10.0.0.100:8080/connect',
        onConnect: onConnect,
        onWebSocketError: (dynamic error) => log(error.toString(), name: 'WEBSOCKET'),
        // stompConnectHeaders: {'Authorization': 'Bearer ${user?.token}'},
        // webSocketConnectHeaders: {'Authorization': 'Bearer ${user?.token}'},
      ),
    );

    stompClient.activate();
  }

  void onConnect(StompFrame frame) async {
    final user = await AppController.instance.currentUser;

    log('CHAMANDO FUNÇÃO DEPOIS DE CONECTADO...', name: 'WEBSOCKET');

    stompClient.subscribe(
      destination: '/project/6a670038-1d35-44d4-bfc5-1be457a4f856',
      callback: (frame) {
        final result = json.decode(frame.body ?? '');
        log('$result', name: 'WEBSOCKET');
      },
      headers: {'Authorization': 'Bearer ${user?.token}'},
    );

    Timer.periodic(const Duration(seconds: 5), (_) {
      log('ENVIANDO MENSAGEM', name: 'WEBSOCKET');

      stompClient.send(
        destination: '/chat/project/6a670038-1d35-44d4-bfc5-1be457a4f856',
        body: json.encode({
          'sender': '${user?.id}',
          'content': 'mensagem',
        }),
        headers: {'Authorization': 'Bearer ${user?.token}'},
      );
    });
  }
}
