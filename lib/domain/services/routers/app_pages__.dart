import 'package:get/get_navigation/get_navigation.dart';
import 'package:kyw_management/app/screens/forms/sign_in_screen.dart';
import 'package:kyw_management/domain/services/routers/my_routes.dart';

abstract class AppPages1 {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.signIn,
      page: () => const SignInScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 200),
    ),
  ];
}
