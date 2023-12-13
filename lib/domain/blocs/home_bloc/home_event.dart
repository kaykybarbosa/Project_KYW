part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class ScreenChangedHome extends HomeEvent {
  const ScreenChangedHome({required this.screen});

  final Screens screen;

  @override
  List<Object> get props => [screen];
}

class HaveMessageHome extends HomeEvent {
  const HaveMessageHome({required this.haveMessage});

  final bool haveMessage;

  @override
  List<Object> get props => [haveMessage];
}
