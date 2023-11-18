import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/screens/forgot_password_screen.dart';
import 'package:kyw_management/app/screens/login_screen.dart';
import 'package:kyw_management/app/screens/project_screen.dart';
import 'package:kyw_management/app/screens/register_screen.dart';

final routes = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: "/", builder: (context, state) => const LoginScreen()),
    GoRoute(
        path: "/register", builder: (context, state) => const RegisterScreen()),
    GoRoute(
        path: "/forgot-password",
        builder: (context, state) => const ForgotPassword()),
    GoRoute(
        path: "/projects", builder: (context, state) => const ProjectScreen())
  ],
);
