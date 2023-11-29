import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyw_management/app/data/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      debugShowCheckedModeBanner: false,
      title: 'KYW Management',
      theme: const CupertinoThemeData(
        primaryColor: Color.fromRGBO(50, 58, 71, 1),
        scaffoldBackgroundColor: CupertinoColors.extraLightBackgroundGray,
        primaryContrastingColor: CupertinoColors.activeBlue,
      ),
      routerDelegate: routes.routerDelegate,
      routeInformationParser: routes.routeInformationParser,
      routeInformationProvider: routes.routeInformationProvider,
      localizationsDelegates: const [
        // DefaultMaterialLocalizations.delegate,
        // DefaultCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('pt'),
      ],
    );
  }
}
