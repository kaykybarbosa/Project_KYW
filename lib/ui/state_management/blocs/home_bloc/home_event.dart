part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class ScreenChanged extends HomeEvent {
  const ScreenChanged({required this.screen});

  final Screens screen;

  @override
  List<Object> get props => [screen];
}

class HaveMessage extends HomeEvent {
  const HaveMessage({required this.haveMessage});

  final bool haveMessage;

  @override
  List<Object> get props => [haveMessage];
}
