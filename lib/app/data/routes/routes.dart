import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/screens/change_password_screen.dart';
import 'package:kyw_management/app/screens/forgot_password_screen.dart';
import 'package:kyw_management/app/screens/form_screen.dart';
import 'package:kyw_management/app/screens/project_screen.dart';
import 'package:kyw_management/app/screens/register_screen.dart';

final routes = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: "/", builder: (context, state) => const FormScreen()),
    GoRoute(
        path: "/register", builder: (context, state) => const RegisterScreen()),
    GoRoute(
        path: "/forgot-password",
        builder: (context, state) => const ForgotPassword()),
    GoRoute(
        path: "/change-password",
        builder: (context, state) => ChangePasswordScreen()),
    GoRoute(
        path: "/projects", builder: (context, state) => const ProjectScreen()),
  ],
);
