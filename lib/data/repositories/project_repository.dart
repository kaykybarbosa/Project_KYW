import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kyw_management/data/dtos/response/all_projects_response.dart';
import 'package:kyw_management/data/services/http_service/http_service.dart';
import 'package:kyw_management/domain/exception/api_exception.dart';
import 'package:result_dart/result_dart.dart';

abstract class IProjectRepository {
  static IProjectRepository get instance => Get.find<IProjectRepository>();

  AsyncResult<AllProjectsResponse, ApiException> getAllProjects();

  AsyncResult<ProjectResponse, ApiException> getProjectById(String projectId);
}

class ProjectRepository implements IProjectRepository {
  ProjectRepository(IHttpService httpService) : _http = httpService;

  final IHttpService _http;

  @override
  AsyncResult<AllProjectsResponse, ApiException> getAllProjects() async {
    try {
      var result = await _http.get('${_http.baseUrl}projects');

      return AllProjectsResponse.fromMap(result.data).toSuccess();
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<ProjectResponse, ApiException> getProjectById(String projectId) async {
    try {
      var result = await _http.get('${_http.baseUrl}projects/$projectId');

      return ProjectResponse.fromMap(result.data).toSuccess();
    } on DioException catch (e) {
      return ApiException(message: e.message).toFailure();
    } catch (e) {
      return ApiException(message: e.toString()).toFailure();
    }
  }
}
