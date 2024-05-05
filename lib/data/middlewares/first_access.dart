// ignore_for_file: overridden_fields

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
  RouteSettings? redirect(String? route) {
    var appController = AppController.instance;
    var configureApp = appController.configureApp;

    if (configureApp.isFirstAccess || !configureApp.currentUserIsAuth) return null;

    return const RouteSettings(name: AppRoutes.automaticSignIn);
  }
}
