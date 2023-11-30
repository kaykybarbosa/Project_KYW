import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/enums/my_routes.dart';
import 'package:kyw_management/app/screens/change_password_screen.dart';
import 'package:kyw_management/app/screens/create_project_screen.dart';
import 'package:kyw_management/app/screens/forgot_password_screen.dart';
import 'package:kyw_management/app/screens/form_screen.dart';
import 'package:kyw_management/app/screens/home_screen.dart';
import 'package:kyw_management/app/screens/notification_screen.dart';

final routes = GoRouter(
  initialLocation: MyRoutes.home,
  routes: [
    GoRoute(
      path: MyRoutes.form,
      builder: (context, state) => const FormScreen(),
    ),
    GoRoute(
        path: MyRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen()),
    GoRoute(
      path: MyRoutes.changePassword,
      builder: (context, state) => const ChangePasswordScreen(),
    ),
    GoRoute(
      path: MyRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: MyRoutes.notifications,
      builder: (context, state) {
        return const NotificationScreen();
      },
    ),
    GoRoute(
      path: MyRoutes.createProject,
      builder: (context, state) {
        return const CreateProjectScreen();
      },
    ),
  ],
);
