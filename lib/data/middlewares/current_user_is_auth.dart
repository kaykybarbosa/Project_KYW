// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/app/routers/my_routes.dart';

// TODO: Remove this
class CurrentUserIsAuthMiddleware extends GetMiddleware {
  @override
  int? priority = 0;

  CurrentUserIsAuthMiddleware({this.priority});

  var appController = AppController.instance;

  @override
  RouteSettings? redirect(String? route) =>
      appController.status.isUnauthenticated ? const RouteSettings(name: AppRoutes.initial) : null;
}
