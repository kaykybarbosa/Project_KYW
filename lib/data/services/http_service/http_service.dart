// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kyw_management/data/interceptors/interceptor_requests.dart';
import 'package:kyw_management/data/interceptors/interceptor_requests_auth.dart';
import 'package:kyw_management/env/env.dart';

abstract class IHttpService {
  static String get AUTH_TAG => 'HTTP_TAG';

  static IHttpService get instance => Get.find<IHttpService>();
  static IHttpService get instanceAuth => Get.find<IHttpService>(tag: AUTH_TAG);

  String get baseUrl;

  Future get<T>(String path);

  Future post<T>(String path, {Object? data, Options? options});

  Future put<T>(String path, {Object? data});

  Future patch<T>(String path, {Object? data});

  Future delete<T>(String path);
}

class HttpService implements IHttpService {
  final _options = BaseOptions(
    baseUrl: Env.BASE_URL,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    maxRedirects: 1,
    sendTimeout: const Duration(seconds: 60),
    headers: {
      'content-Type': 'application/json',
    },
  );

  late Dio _dio;

  HttpService() {
    _dio = Dio(_options);
    _dio.interceptors.add(InterceptorRequests());
  }

  HttpService.auth() {
    _dio = Dio(_options);
    _dio.interceptors.add(InterceptorRequestsAuth());
  }

  @override
  String get baseUrl => _options.baseUrl;

  @override
  Future get<T>(String path) async {
    return await _dio.get<T>(path);
  }

  @override
  Future post<T>(String path, {Object? data, Options? options}) async =>
      await _dio.post<T>(path, data: data, options: options);

  @override
  Future put<T>(String path, {Object? data}) async => await _dio.put<T>(path, data: data);

  @override
  Future patch<T>(String path, {Object? data}) async => await _dio.patch(path, data: data);

  @override
  Future delete<T>(String path) async => await _dio.delete(path);
}
