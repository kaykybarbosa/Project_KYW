import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kyw_management/domain/blocs/blocs_export.dart';
import 'package:kyw_management/domain/repositories/project_repository.dart';
import 'package:kyw_management/domain/services/routers/app_routes.dart';
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
        BlocProvider(
          create: (context) => ProjectBloc()
            ..add(AddProjects(projects: ProjectRepository().projects) // Data static
                ),
        ),
        BlocProvider(create: (context) => SignInBloc()),
        BlocProvider(create: (context) => SignUpBloc()),
        BlocProvider(create: (context) => ForgotPasswordBloc()),
        BlocProvider(create: (context) => HomeBloc()),
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
        routerDelegate: appRoutes.routerDelegate,
        routeInformationParser: appRoutes.routeInformationParser,
        routeInformationProvider: appRoutes.routeInformationProvider,
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
