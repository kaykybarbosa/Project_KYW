import 'package:get/get.dart';
import 'package:kyw_management/ui/screens/project/sub_screens/project_details_screen.dart';

import 'app_pages_exports.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.initial,
      page: () => const WelcomeScreen(),
      middlewares: [FirsAccessMiddleware(priority: 0)],
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      transition: Transition.fade,
      bindings: [
        AppControllerBindings(),
        HttpServiceBindings(),
        RepositoriesBindings(),
        AuthRepositoryBindings(),
      ],
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => const SignInScreen(),
      bindings: [
        HttpServiceBindings(),
        AuthRepositoryBindings(),
        ServicesBindings(),
      ],
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: TConstants.transitionFadeDuration),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => const SignUpScreen(),
      bindings: [
        HttpServiceBindings(),
        AuthRepositoryBindings(),
      ],
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: TConstants.transitionFadeDuration),
    ),
    GetPage(
      name: AppRoutes.automaticSignIn,
      page: () => const AutomaticSignInScreen(),
      bindings: [
        AuthRepositoryBindings(),
        ServicesBindings(),
      ],
      transition: Transition.fade,
      transitionDuration: Duration.zero,
    ),
    GetPage(
      fullscreenDialog: true,
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      transition: Transition.fade,
      transitionDuration: TConstants.transitionFadeDuration.milliseconds,
    ),
    GetPage(
      name: AppRoutes.codeForgotPassword,
      page: () => const CodeForgotScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: TConstants.transitionFadeDuration.milliseconds,
    ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => const ChangePasswordScreen(),
      transition: Transition.fade,
      transitionDuration: TConstants.transitionFadeDuration.milliseconds,
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
      name: AppRoutes.detailsProject,
      page: () => const ProjectDetailsScreen(),
      transitionDuration: 600.milliseconds,
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
      page: () => ChatProjectScreen(projectId: Get.parameters['id']!),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.taskDetails,
      page: () => DetailsTaskScreen(taskId: Get.parameters['id']!),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.createTask,
      page: () => CreateTaskScreen(projectId: Get.parameters['id']!),
      transition: Transition.fade,
      fullscreenDialog: true,
    ),
  ];
}
