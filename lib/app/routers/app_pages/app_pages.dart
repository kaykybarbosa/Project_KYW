import 'app_pages_exports.dart';

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
      transition: Transition.rightToLeftWithFade,
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
