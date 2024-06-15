import 'dart:developer' as dev;

import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    dev.log('onCreate -- ${bloc.runtimeType}', name: 'BLOC');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    dev.log('=====================================================');
    dev.log('onChange -- ${bloc.runtimeType}', name: 'BLOC');
    dev.inspect(change.currentState);
    dev.inspect(change.nextState);
    dev.log('=====================================================');
  }
}
