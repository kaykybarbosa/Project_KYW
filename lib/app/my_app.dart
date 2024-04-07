import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/app_pages.dart';
import 'package:kyw_management/app/routers/my_routes.dart';
import 'package:kyw_management/app/theme/app_theme.dart';
import 'package:kyw_management/ui/state_management/blocs/add_project_bloc/add_project_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/filter_project_bloc/filter_project_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/filter_task_bloc/filter_task_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/home_bloc/home_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:kyw_management/ui/state_management/blocs/sign_up_bloc/sign_up_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProjectBloc()),
        BlocProvider(create: (context) => SignInBloc()),
        BlocProvider(create: (context) => SignUpBloc()),
        BlocProvider(create: (context) => ForgotPasswordBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => AddProjectBloc()),
        BlocProvider(create: (context) => FilterProjectBloc()),
        BlocProvider(create: (context) => FilterTaskBloc()),
        BlocProvider(create: (context) => AddProjectBloc()),
      ],
      child: GetMaterialApp(
        theme: AppTheme.light,
        title: 'KYW Management',
        getPages: AppPages.pages,
        initialRoute: AppRoutes.home,
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
}
