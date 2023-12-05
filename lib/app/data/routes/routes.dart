import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/data/chats.dart';
import 'package:kyw_management/app/enums/my_routes.dart';
import 'package:kyw_management/app/screens/change_password_screen.dart';
import 'package:kyw_management/app/screens/configuration_screen.dart';
import 'package:kyw_management/app/screens/configuration_screens/change_number_screen.dart';
import 'package:kyw_management/app/screens/configuration_screens/configuration_account_screen.dart';
import 'package:kyw_management/app/screens/configuration_screens/delete_account_screen.dart';
import 'package:kyw_management/app/screens/configuration_screens/two_step_verification_screen.dart';
import 'package:kyw_management/app/screens/contact_us_screen.dart';
import 'package:kyw_management/app/screens/create_project_screen.dart';
import 'package:kyw_management/app/screens/forgot_password_screen.dart';
import 'package:kyw_management/app/screens/form_screen.dart';
import 'package:kyw_management/app/screens/help_screen.dart';
import 'package:kyw_management/app/screens/home_screen.dart';
import 'package:kyw_management/app/screens/my_account_screen.dart';
import 'package:kyw_management/app/screens/notification_screen.dart';
import 'package:kyw_management/app/widgets/home_screen/chat/ChatProject.dart';

final routes = GoRouter(
  initialLocation: MyRoutes.home,
  routes: [
    GoRoute(
      path: MyRoutes.form,
      builder: (context, state) => const FormScreen(),
    ),
    GoRoute(
      path: MyRoutes.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
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
      path: MyRoutes.configurationTwoStep,
      builder: (context, state) => const TwoStepVerificationScreen(),
    ),
    GoRoute(
      path: MyRoutes.configurationChangeNumber,
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
