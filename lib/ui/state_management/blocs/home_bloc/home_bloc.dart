import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kyw_management/domain/enums/screens.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(const HomeInitial(
          currentScreen: Screens.project,
          haveMessage: true,
        )) {
    on<ScreenChangedHome>(_onScreenChanged);
    on<HaveMessageHome>(_onHaveMessage);
  }

  void _onScreenChanged(ScreenChangedHome event, Emitter<HomeState> emit) {
    emit(state.copyWith(currentScreen: event.screen));
  }

  void _onHaveMessage(HaveMessageHome event, Emitter<HomeState> emit) {
    emit(state.copyWith(haveMessage: event.haveMessage));
  }
}
