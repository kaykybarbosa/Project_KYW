import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages.dart';
import 'package:kyw_management/app/routers/my_routes.dart';
import 'package:kyw_management/app/theme/app_theme.dart';
import 'package:kyw_management/data/repositories/auth/auth_repository.dart';
import 'package:kyw_management/data/repositories/project_repository.dart';
import 'package:kyw_management/data/services/configure_login_service.dart';
import 'package:kyw_management/data/services/message_service.dart';
import 'package:kyw_management/data/services/web_socket_client.dart';
import 'package:kyw_management/ui/state_management/blocs/add_project_bloc/add_project_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/filter_project_bloc/filter_project_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/filter_task_bloc/filter_task_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/home_bloc/home_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_bloc.dart';
import 'package:kyw_management/ui/state_management/cubits/authenticate_user_cubit/authenticate_user_cubit.dart';
import 'package:kyw_management/ui/state_management/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:kyw_management/ui/state_management/cubits/sign_up_cubit/sign_up_cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ForgotPasswordBloc()),
          BlocProvider(create: (_) => HomeBloc()),
          BlocProvider(create: (_) => FilterProjectBloc()),
          BlocProvider(create: (_) => FilterTaskBloc()),
          BlocProvider(create: (_) => AddProjectBloc()),
          BlocProvider(
            create: (_) => ProjectBloc(
              projectRepository: IProjectRepository.instance,
              webSocket: WebSocketClient.instance,
              messageService: IMessageService.instance,
              appController: AppController.instance,
            ),
          ),
          BlocProvider(
            create: (_) => SignUpCubit(
              authRepository: IAuthRepository.instance,
              appController: AppController.instance,
            ),
          ),
          BlocProvider(
            create: (_) => AuthenticateUserCubit(
              appController: AppController.instance,
              authRepository: IAuthRepository.instance,
              authSettings: IAuthSettingsService.instance,
            ),
          ),
          BlocProvider(
            create: (_) => SignInCubit(
              authRepository: IAuthRepository.instance,
              authSettings: IAuthSettingsService.instance,
            ),
          ),
        ],
        child: GetMaterialApp(
          theme: AppTheme.light,
          title: 'KYW Management',
          getPages: AppPages.pages,
          initialRoute: AppRoutes.initial,
          debugShowCheckedModeBanner: false,
          supportedLocales: const [Locale('pt')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
        ),
      );
}
