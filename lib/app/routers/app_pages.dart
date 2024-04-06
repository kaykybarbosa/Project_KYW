import 'package:get/get_navigation/get_navigation.dart';
import 'package:kyw_management/app/routers/my_routes.dart';
import 'package:kyw_management/ui/screens/add_project/create_project_screen.dart';
import 'package:kyw_management/ui/screens/add_project/invite_friends__screen.dart';
import 'package:kyw_management/ui/screens/chat/chat_project_screen.dart';
import 'package:kyw_management/ui/screens/configuration_screen.dart';
import 'package:kyw_management/ui/screens/configuration_screens/change_email_screen.dart';
import 'package:kyw_management/ui/screens/configuration_screens/change_number_or_email_screen.dart';
import 'package:kyw_management/ui/screens/configuration_screens/change_number_screen.dart';
import 'package:kyw_management/ui/screens/configuration_screens/configuration_account_screen.dart';
import 'package:kyw_management/ui/screens/configuration_screens/delete_account_screen.dart';
import 'package:kyw_management/ui/screens/configuration_screens/two_step_verification_screen.dart';
import 'package:kyw_management/ui/screens/contact_us_screen.dart';
import 'package:kyw_management/ui/screens/forms/sign_in_screen.dart';
import 'package:kyw_management/ui/screens/forms/sign_up_screen.dart';
import 'package:kyw_management/ui/screens/help_screen.dart';
import 'package:kyw_management/ui/screens/home/home_screen.dart';
import 'package:kyw_management/ui/screens/my_account_screen.dart';
import 'package:kyw_management/ui/screens/notification_screen.dart';
import 'package:kyw_management/ui/screens/steps_forgot_password/change_password_screen.dart';
import 'package:kyw_management/ui/screens/steps_forgot_password/code_forgot_screen.dart';
import 'package:kyw_management/ui/screens/steps_forgot_password/email_forgot_screen.dart';
import 'package:kyw_management/utils/constants.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.signIn,
      page: () => const SignInScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: TConstants.millisecondsAnimation),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => const SignUpScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: TConstants.millisecondsAnimation),
    ),
    GetPage(
      name: AppRoutes.emailForgotPassword,
      page: () => const EmailForgotScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: TConstants.millisecondsAnimation),
    ),
    GetPage(
      name: AppRoutes.codeForgotPassword,
      page: () => const CodeForgotScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: TConstants.millisecondsAnimation),
    ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => const ChangePasswordScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: TConstants.millisecondsAnimation),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.createProject,
      page: () => const CreateProjectScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.inviteFriends,
      page: () => const InviteFriendsScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.configuration,
      page: () => const ConfigurationScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.myAccount,
      page: () => const MyAccountScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.help,
      page: () => HelpScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.contactUs,
      page: () => const ContactUsScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.configurationAccount,
      page: () => const ConfigurationAccountScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.twoStepVerification,
      page: () => const TwoStepVerificationScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.changeNumberOrEmail,
      page: () => const ChangeNumberOrEmail(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.changeNumber,
      page: () => const ChangeNumberScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.changeEmail,
      page: () => const ChangeEmailScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.configurationDeleteAccount,
      page: () => const DeleteAccountScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatProjectScreen(),
      transition: Transition.fade,
    ),
  ];
}
