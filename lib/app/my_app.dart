import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kyw_management/domain/blocs/sign_in_export.dart';
import 'package:kyw_management/domain/services/app_routes/app_routes.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProjectsBloc()
            ..add(AddProjects(
                    projects: ProjectRepository().projects) // Data static
                ),
        ),
        BlocProvider(create: (context) => SignInBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'KYW Management',
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(50, 58, 71, 1),
          scaffoldBackgroundColor: Colors.grey[200],
          elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
              padding:
                  MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 10)),
              foregroundColor: MaterialStatePropertyAll(Colors.white),
              backgroundColor:
                  MaterialStatePropertyAll(Color.fromRGBO(50, 58, 71, 1)),
              overlayColor: MaterialStatePropertyAll(Colors.grey),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)))),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.grey),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          ),
        ),
        routerDelegate: appRoutes.routerDelegate,
        routeInformationParser: appRoutes.routeInformationParser,
        routeInformationProvider: appRoutes.routeInformationProvider,
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
