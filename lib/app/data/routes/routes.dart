import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/enums/my_route.dart';
import 'package:kyw_management/app/screens/change_password_screen.dart';
import 'package:kyw_management/app/screens/forgot_password_screen.dart';
import 'package:kyw_management/app/screens/form_screen.dart';
import 'package:kyw_management/app/screens/home_screen.dart';
import 'package:kyw_management/app/screens/notification_screen.dart';
import 'package:kyw_management/app/screens/project_screen.dart';

final routes = GoRouter(
  initialLocation: MyRoute.home,
  routes: [
    GoRoute(
      path: MyRoute.form,
      builder: (context, state) => const FormScreen(),
    ),
    GoRoute(
        path: MyRoute.forgotPassword,
        builder: (context, state) => const ForgotPassword()),
    GoRoute(
      path: MyRoute.changePassword,
      builder: (context, state) => ChangePasswordScreen(),
    ),
    GoRoute(
      path: MyRoute.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: MyRoute.projects,
      builder: (context, state) => const ProjectScreen(),
    ),
    GoRoute(
      path: MyRoute.notifications,
      builder: (context, state) {
        return NotificationScreen(context: context);
      },
    ),
  ],
);
