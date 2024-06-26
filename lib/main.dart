import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/app/my_app.dart';
import 'package:kyw_management/dependency_injection/dependency_injections.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = ProjectBlocObserver();
  await dependencyInjections();

  runApp(const MyApp());
}
