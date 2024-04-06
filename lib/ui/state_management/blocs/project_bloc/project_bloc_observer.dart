import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('=====================================================');
    print('onChange -- ${bloc.runtimeType}, $change');
    print('=====================================================');
  }
}
