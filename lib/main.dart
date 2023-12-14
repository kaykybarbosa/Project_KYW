import 'package:flutter/cupertino.dart';
import 'package:kyw_management/app/my_app.dart';
import 'package:kyw_management/domain/blocs/blocs_export.dart';
import 'package:kyw_management/domain/blocs/project_bloc/project_bloc_observer.dart';

void main() {
  Bloc.observer = ProjectBlocObserver();
  runApp(const MyApp());
}
