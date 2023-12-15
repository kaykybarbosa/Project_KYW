// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_task_bloc.dart';

class FilterTaskState extends Equatable {
  final bool pending;
  final bool complete;
  final bool incomplete;
  final bool showMyCategories;
  final List<MyCategory> categories;

  const FilterTaskState({
    required this.pending,
    required this.complete,
    required this.incomplete,
    required this.showMyCategories,
    required this.categories,
  });

  @override
  List<Object> get props => [
        pending,
        complete,
        incomplete,
        showMyCategories,
        categories,
      ];

  FilterTaskState copyWith({
    bool? pending,
    bool? complete,
    bool? incomplete,
    bool? showMyCategories,
    List<MyCategory>? categories,
  }) {
    return FilterTaskState(
      pending: pending ?? this.pending,
      complete: complete ?? this.complete,
      incomplete: incomplete ?? this.incomplete,
      showMyCategories: showMyCategories ?? this.showMyCategories,
      categories: categories ?? this.categories,
    );
  }
}

final class FilterTaskInitial extends FilterTaskState {
  const FilterTaskInitial({
    required super.pending,
    required super.complete,
    required super.incomplete,
    required super.showMyCategories,
    required super.categories,
  });
}
