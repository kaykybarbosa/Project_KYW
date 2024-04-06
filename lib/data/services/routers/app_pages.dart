import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/data/services/routers/my_routes.dart';
import 'package:kyw_management/domain/models/project.dart';
import 'package:kyw_management/ui/screens/chat/chat_project_screen.dart';
import 'package:kyw_management/ui/screens/configuration_screens/change_number_or_email_screen.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_bloc.dart';

import '../../../ui/screens/screens_export.dart';

final appPages = GoRouter(
  navigatorKey: Get.key,
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.signIn,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: AppRoutes.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: AppRoutes.emailForgotPassword,
      builder: (context, state) => const EmailForgotScreen(),
    ),
    GoRoute(
      path: AppRoutes.codeForgotPassword,
      builder: (context, state) => const CodeForgotScreen(),
    ),
    GoRoute(
      path: AppRoutes.changePassword,
      builder: (context, state) => const ChangePasswordScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.notifications,
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: AppRoutes.createProject,
      builder: (context, state) => const CreateProjectScreen(),
    ),
    GoRoute(
      path: AppRoutes.inviteFriends,
      builder: (context, state) => const InviteFriendsScreen(),
    ),
    GoRoute(
      path: AppRoutes.configuration,
      builder: (context, state) => const ConfigurationScreen(),
    ),
    GoRoute(
      path: AppRoutes.myAccount,
      builder: (context, state) => const MyAccountScreen(),
    ),
    GoRoute(
      path: AppRoutes.help,
      builder: (context, state) => HelpScreen(),
    ),
    GoRoute(
      path: AppRoutes.contactUs,
      builder: (context, state) => const ContactUsScreen(),
    ),
    GoRoute(
      path: AppRoutes.configurationAccount,
      builder: (context, state) => const ConfigurationAccountScreen(),
    ),
    GoRoute(
      path: AppRoutes.twoStepVerification,
      builder: (context, state) => const TwoStepVerificationScreen(),
    ),
    GoRoute(
      path: AppRoutes.changeNumberOrEmail,
      builder: (context, state) => const ChangeNumberOrEmail(),
    ),
    GoRoute(
      path: AppRoutes.changeNumber,
      builder: (context, state) => const ChangeNumberScreen(),
    ),
    GoRoute(
      path: AppRoutes.changeEmail,
      builder: (context, state) => const ChangeEmailScreen(),
    ),
    GoRoute(
      path: AppRoutes.configurationDeleteAccount,
      builder: (context, state) => const DeleteAccountScreen(),
    ),
    GoRoute(
      path: AppRoutes.chat,
      builder: (context, state) {
        final projectId = int.parse(state.pathParameters['projectId']!);

        Project project = context.select((ProjectBloc bloc) => bloc.state.allProject[projectId]);

        return ChatProjectScreen(project: project);
      },
    ),
  ],
);
