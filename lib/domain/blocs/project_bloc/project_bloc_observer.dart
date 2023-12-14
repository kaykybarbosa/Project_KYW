import 'package:kyw_management/domain/blocs/blocs_export.dart';

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
