import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kyw_management/data/dtos/request/create_task_request.dart';
import 'package:kyw_management/data/dtos/response/all_tasks_response.dart';
import 'package:kyw_management/data/services/http_service/http_service.dart';
import 'package:kyw_management/domain/exception/api_exception.dart';
import 'package:result_dart/result_dart.dart';

abstract class ITaskRepository {
  static ITaskRepository get instance => Get.find();

  AsyncResult<AllTasksResponse, ApiException> getAllTasks();

  AsyncResult<TaskResponse, ApiException> getTaskById(String taskId);

  AsyncResult<Unit, ApiException> createTask(CreateTaskRequest request);

  AsyncResult<TaskResponse, ApiException> updateTask(TaskResponse task);
}

class TaskRepository implements ITaskRepository {
  TaskRepository(IHttpService httpService) : _http = httpService;

  final IHttpService _http;
  @override
  AsyncResult<AllTasksResponse, ApiException> getAllTasks() async {
    try {
      final result = await _http.get('${_http.baseUrl}/tasks');

      return AllTasksResponse.fromMap(result.data).toSuccess();
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<TaskResponse, ApiException> getTaskById(String taskId) async {
    try {
      final result = await _http.get('${_http.baseUrl}/tasks/$taskId');

      return TaskResponse.fromMap(result.data).toSuccess();
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<Unit, ApiException> createTask(CreateTaskRequest request) async {
    try {
      await _http.post(
        '${_http.baseUrl}/tasks',
        data: request.toJson(),
      );

      return const Success(unit);
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<TaskResponse, ApiException> updateTask(TaskResponse task) async {
    try {
      final result = await _http.post(
        '${_http.baseUrl}/tasks',
        data: task.toJson(),
      );

      return Success(TaskResponse.fromJson(result));
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }
}
