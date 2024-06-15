class ApiException implements Exception {
  ApiException({this.message, this.statusCode});

  final String? message;
  final int? statusCode;
}
