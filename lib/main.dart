import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyw_management/app/my_app.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_bloc_observer.dart';

void main() {
  Bloc.observer = ProjectBlocObserver();
  runApp(const MyApp());
}
