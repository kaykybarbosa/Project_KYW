import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/app/routers/my_routes.dart';
import 'package:kyw_management/ui/screens/authentication/widgets/splash_screen.dart';
import 'package:kyw_management/ui/state_management/cubits/authenticate_user_cubit/authenticate_user_cubit.dart';

class AutomaticSignInScreen extends StatefulWidget {
  const AutomaticSignInScreen({super.key});

  @override
  State<AutomaticSignInScreen> createState() => _AutomaticSignInScreenState();
}

class _AutomaticSignInScreenState extends State<AutomaticSignInScreen> {
  void _authenticate() => context.read<AuthenticateUserCubit>().authenticate();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => _authenticate());
  }

  @override
  Widget build(BuildContext context) => BlocListener<AuthenticateUserCubit, AuthenticateUserState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status.isSuccess) {
            Get.offAllNamed(AppRoutes.home);
          } else if (state.status.isFailure) {
            var controller = AppController.instance;

            controller.setConfigurations(controller.configureApp.copyWith(currentUserIsAuth: false));
            Get.offAllNamed(AppRoutes.initial);
          }
        },
        child: const Scaffold(
          body: SplashScreen(
            width: 122,
            height: 122,
            progressVisible: true,
          ),
        ),
      );
}
