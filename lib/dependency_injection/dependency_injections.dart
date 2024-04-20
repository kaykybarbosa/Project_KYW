import 'package:kyw_management/data/repositories/auth/auth_repository_bindings.dart';
import 'package:kyw_management/data/services/http_service/http_service_bindings.dart';

Future<void> dependencyInjections() async {
  HttpServiceBindings().dependencies();
  AuthRepositoryBindings().dependencies();
}
