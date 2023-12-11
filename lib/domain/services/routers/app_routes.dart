import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/data/chats.dart';
import 'package:kyw_management/app/enums/my_routes.dart';
import 'package:kyw_management/app/screens/configuration_screens/change_number_or_email_screen.dart';

import 'package:kyw_management/app/widgets/home_screen/chat/ChatProject.dart';

import '../../../app/screens/screens_export.dart';

final appRoutes = GoRouter(
  initialLocation: MyRoutes.home,
  routes: [
    GoRoute(
      path: MyRoutes.signIn,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: MyRoutes.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: MyRoutes.emailForgotPassword,
      builder: (context, state) => const EmailForgotScreen(),
    ),
    GoRoute(
      path: MyRoutes.codeForgotPassword,
      builder: (context, state) => const CodeForgotScreen(),
    ),
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
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: MyRoutes.createProject,
      builder: (context, state) => const CreateProjectScreen(),
    ),
    GoRoute(
      path: MyRoutes.configuration,
      builder: (context, state) => const ConfigurationScreen(),
    ),
    GoRoute(
      path: MyRoutes.myAccount,
      builder: (context, state) => const MyAccountScreen(),
    ),
    GoRoute(
      path: MyRoutes.help,
      builder: (context, state) => HelpScreen(),
    ),
    GoRoute(
      path: MyRoutes.contactUs,
      builder: (context, state) => const ContactUsScreen(),
    ),
    GoRoute(
      path: MyRoutes.configurationAccount,
      builder: (context, state) => const ConfigurationAccountScreen(),
    ),
    GoRoute(
      path: MyRoutes.twoStepVerification,
      builder: (context, state) => const TwoStepVerificationScreen(),
    ),
    GoRoute(
      path: MyRoutes.changeNumberOrEmail,
      builder: (context, state) => const ChangeNumberOrEmail(),
    ),
    GoRoute(
      path: MyRoutes.changeNumber,
      builder: (context, state) => const ChangeNumberScreen(),
    ),
    GoRoute(
      path: MyRoutes.configurationDeleteAccount,
      builder: (context, state) => const DeleteAccountScreen(),
    ),
    GoRoute(
      path: MyRoutes.chat,
      builder: (context, state) {
        final projectId = int.parse(state.pathParameters['projectId']!);

        final chat = chats[projectId];

        return ChatProject(chat: chat);
      },
    ),
  ],
);
