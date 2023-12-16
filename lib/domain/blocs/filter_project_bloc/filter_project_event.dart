part of 'filter_project_bloc.dart';

sealed class FilterProjectEvent extends Equatable {
  const FilterProjectEvent();

  @override
  List<Object> get props => [];
}

class InitDateChanged extends FilterProjectEvent {
  const InitDateChanged({required this.initDate});

  final String initDate;

  @override
  List<Object> get props => [initDate];
}

class FinalDateChanged extends FilterProjectEvent {
  const FinalDateChanged({required this.finalDate});

  final String finalDate;

  @override
  List<Object> get props => [finalDate];
}

class CreatedByMeChanged extends FilterProjectEvent {}

class MarkedChanged extends FilterProjectEvent {}

class IsInitDateChanged extends FilterProjectEvent {}

class ResetFilterProject extends FilterProjectEvent {
  const ResetFilterProject({required this.resetDates});

  final bool resetDates;

  @override
  List<Object> get props => [resetDates];
}
