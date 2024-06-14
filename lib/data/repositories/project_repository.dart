import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:kyw_management/data/dtos/request/create_project_request.dart';
import 'package:kyw_management/data/dtos/response/all_projects_response.dart';
import 'package:kyw_management/data/dtos/response/all_tasks_response.dart';
import 'package:kyw_management/data/dtos/response/detail_project_response.dart';
import 'package:kyw_management/data/dtos/response/member_of_project_response.dart';
import 'package:kyw_management/data/services/http_service/http_service.dart';
import 'package:kyw_management/domain/exception/api_exception.dart';
import 'package:result_dart/result_dart.dart';

abstract class IProjectRepository {
  static IProjectRepository get instance => Get.find<IProjectRepository>();

  AsyncResult<Unit, ApiException> createProject(CreateProjectRequest request);

  AsyncResult<List<ProjectResponse>, ApiException> getAllProjects();

  AsyncResult<DetailProjectResponse, ApiException> getProjectById(String projectId);

  AsyncResult<List<TaskResponse>, ApiException> getAllTasks(String projectId);

  AsyncResult<Unit, ApiException> addMemberByUserId(String projectId, {required String userId});

  AsyncResult<Unit, ApiException> addMemberByEmail(String projectId, {required String email});

  AsyncResult<List<MemberOfProjectResponse>, ApiException> getAllMembers(String projectId);

  AsyncResult<Unit, ApiException> signOutProject(String projectId);
}

class ProjectRepository implements IProjectRepository {
  ProjectRepository(IHttpService httpService) : _http = httpService;

  final IHttpService _http;

  @override
  AsyncResult<Unit, ApiException> createProject(CreateProjectRequest request) async {
    try {
      final members = request.members.isNotEmpty ? request.members : null;

      Map<String, dynamic> map = {
        'name': request.name,
        'description': request.description,
        'members': members,
      };

      if (request.image != null) {
        final image = await MultipartFile.fromFile(request.image!.path);

        map = {
          'image': image,
          'name': request.name,
          'description': request.description,
          'members': members,
        };
      }

      FormData formData = FormData.fromMap(map);

      await _http.post(
        '${_http.baseUrl}/projects',
        data: formData,
      );

      return const Success(unit);
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<List<ProjectResponse>, ApiException> getAllProjects() async {
    try {
      final result = await _http.get('${_http.baseUrl}/users/projects');

      final projects = result.data.map<ProjectResponse>((project) => ProjectResponse.fromMap(project)).toList();

      return Success(projects);
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<DetailProjectResponse, ApiException> getProjectById(String projectId) async {
    try {
      final result = await _http.get('${_http.baseUrl}/projects/$projectId');

      return DetailProjectResponse.fromMap(result.data).toSuccess();
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<List<TaskResponse>, ApiException> getAllTasks(String projectId) async {
    try {
      final result = await _http.get('${_http.baseUrl}/projects/$projectId/tasks');

      final tasks = result.data.map<TaskResponse>((task) => TaskResponse.fromMap(task)).toList();

      return Success(tasks);
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<Unit, ApiException> addMemberByUserId(
    String projectId, {
    required String userId,
  }) async {
    try {
      String url = '$userId/$projectId';

      await _http.post('${_http.baseUrl}/members/add/$url');

      return const Success(unit);
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<Unit, ApiException> addMemberByEmail(String projectId, {required String email}) async {
    try {
      await _http.post(
        '${_http.baseUrl}/members/add/$projectId',
        params: {'email': email},
      );

      return const Success(unit);
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<List<MemberOfProjectResponse>, ApiException> getAllMembers(String projectId) async {
    try {
      final result = await _http.get('${_http.baseUrl}/members/$projectId');

      final members =
          result.data.map<MemberOfProjectResponse>((member) => MemberOfProjectResponse.fromMap(member)).toList();

      return Success(members);
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<Unit, ApiException> signOutProject(String projectId) async {
    try {
      await _http.post('${_http.baseUrl}/users/exit/$projectId');

      return const Success(unit);
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }
}
