part of 'filter_task_bloc.dart';

sealed class FilterTaskEvent extends Equatable {
  const FilterTaskEvent();

  @override
  List<Object> get props => [];
}

class PendingChanged extends FilterTaskEvent {}

class CompleteChanged extends FilterTaskEvent {}

class IncompleteChanged extends FilterTaskEvent {}

class ShowMyCategoriesChanged extends FilterTaskEvent {}

class AddCategory extends FilterTaskEvent {
  const AddCategory({required this.category});

  final MyCategory category;

  @override
  List<Object> get props => [category];
}

class UpdateCategory extends FilterTaskEvent {
  const UpdateCategory({required this.category});

  final MyCategory category;

  @override
  List<Object> get props => [category];
}

class ResetFilterTask extends FilterTaskEvent {}
