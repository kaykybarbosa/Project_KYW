// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.currentScreen,
    required this.haveMessage,
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

final class HomeInitial extends HomeState {
  const HomeInitial({
    required super.currentScreen,
    required super.haveMessage,
  });
}
