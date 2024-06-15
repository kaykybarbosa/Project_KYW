part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.currentScreen = Screens.project,
    this.haveMessage = true,
  });

  final Screens currentScreen;
  final bool haveMessage;

  @override
  List<Object> get props => [currentScreen, haveMessage];

  HomeState copyWith({
    Screens? currentScreen,
    bool? haveMessage,
  }) {
    return HomeState(
      currentScreen: currentScreen ?? this.currentScreen,
      haveMessage: haveMessage ?? this.haveMessage,
    );
  }
}
