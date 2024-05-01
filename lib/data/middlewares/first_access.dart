import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/app/routers/my_routes.dart';

class FirsAccessMiddleware extends GetMiddleware {
  @override
  int? priority = 0;

  FirsAccessMiddleware({this.priority});

  var configureApp = AppController.instance.configureApp;

  @override
  RouteSettings? redirect(String? route) =>
      configureApp.isFirstAccess ? const RouteSettings(name: AppRoutes.signIn) : null;
}
