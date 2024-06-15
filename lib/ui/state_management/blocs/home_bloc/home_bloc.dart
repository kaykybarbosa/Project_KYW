import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kyw_management/domain/enums/screens.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<ScreenChanged>(_onScreenChanged);
    on<HaveMessage>(_onHaveMessage);
  }

  void _onScreenChanged(ScreenChanged event, Emitter<HomeState> emit) {
    emit(state.copyWith(currentScreen: event.screen));
  }

  void _onHaveMessage(HaveMessage event, Emitter<HomeState> emit) {
    emit(state.copyWith(haveMessage: event.haveMessage));
  }
}
