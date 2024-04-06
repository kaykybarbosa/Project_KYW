import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kyw_management/domain/blocs/add_project_bloc/add_project_bloc.dart';
import 'package:kyw_management/domain/blocs/filter_project_bloc/filter_project_bloc.dart';
import 'package:kyw_management/domain/blocs/filter_task_bloc/filter_task_bloc.dart';
import 'package:kyw_management/domain/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:kyw_management/domain/blocs/home_bloc/home_bloc.dart';
import 'package:kyw_management/domain/blocs/project_bloc/project_bloc.dart';
import 'package:kyw_management/domain/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:kyw_management/domain/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:kyw_management/domain/services/routers/app_pages.dart';
import 'package:kyw_management/theme.dart';

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
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'KYW Management',
        theme: theme,
        routerDelegate: appPages.routerDelegate,
        routeInformationParser: appPages.routeInformationParser,
        routeInformationProvider: appPages.routeInformationProvider,
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
