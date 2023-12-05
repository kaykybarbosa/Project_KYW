import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:kyw_management/app/data/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kyw_management/domain/blocs/bloc_export.dart';
import 'package:kyw_management/domain/repositories/project_repository.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

DateFormat formatter = DateFormat("dd/MM/yyyy");

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectsBloc()
        ..add(
          AddProjects(projects: ProjectRepository().projects), // Data static
        ),
      child: CupertinoApp.router(
        debugShowCheckedModeBanner: false,
        title: 'KYW Management',
        theme: const CupertinoThemeData(
          primaryColor: Color.fromRGBO(50, 58, 71, 1),
          scaffoldBackgroundColor: CupertinoColors.extraLightBackgroundGray,
          primaryContrastingColor: CupertinoColors.activeBlue,
          barBackgroundColor: Color.fromRGBO(50, 58, 71, 1),
        ),
        routerDelegate: routes.routerDelegate,
        routeInformationParser: routes.routeInformationParser,
        routeInformationProvider: routes.routeInformationProvider,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('pt'),
        ],
      ),
    );
  }
}
