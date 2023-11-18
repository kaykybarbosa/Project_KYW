import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/screens/forgot_password_screen.dart';
import 'package:kyw_management/app/screens/login_screen.dart';
import 'package:kyw_management/app/screens/project_screen.dart';
import 'package:kyw_management/app/screens/register_screen.dart';

final routes = GoRouter(
  initialLocation: "/login",
  routes: [
    GoRoute(
        path: "/login",
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        }),
    GoRoute(
        path: "/register",
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterScreen();
        }),
    GoRoute(
        path: "/forgot-password",
        builder: (BuildContext context, GoRouterState state) {
          return const ForgotPassoword();
        }),
    GoRoute(
        path: "/projects",
        builder: (BuildContext context, GoRouterState state) {
          return const ProjectScreen();
        })
  ],
);
